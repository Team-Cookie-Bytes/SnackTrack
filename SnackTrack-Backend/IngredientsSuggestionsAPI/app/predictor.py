from typing import List, Tuple
import torchvision
import torch
from torch import load
import pickle
from sklearn.preprocessing import MultiLabelBinarizer
import pandas as pd
import numpy as np


def sort_tensors_based_on_first(tensor1, tensor2):
    # Sort tensor1 and get the indices
    sorted_tensor1, indices = torch.sort(tensor1)

    # Reorder tensor2 using indices
    sorted_tensor2 = tensor2[indices]

    return sorted_tensor1, sorted_tensor2


def make_horizontal(img):
    c, h, w = img.shape
    if h > w:
        return np.reshape(img, (c, w, h))
    else:
        return img


def get_center_crop(image, crop_w, crop_h):
    _, h, w = image.shape
    assert crop_w < w and crop_h < h

    start_x = w // 2 - crop_w // 2
    start_y = h // 2 - crop_h // 2

    return image[:, start_y : start_y + crop_h, start_x : start_x + crop_w]


class Predictor:
    def __init__(self, num_classes=247):
        self.model = torchvision.models.mobilenet_v3_small()
        self.model.eval()

        num_ftrs = self.model.classifier[3].in_features
        self.model.classifier[3] = torch.nn.Linear(num_ftrs, num_classes)

        with open("./app/state/model_state.pt", "rb") as f:
            self.model.load_state_dict(load(f))

        with open("./app/state/mlb.pkl", "rb") as f:
            self.mlb: MultiLabelBinarizer = pickle.load(f)

        self.df = pd.read_csv("./app/state/ingredients_metadata.csv")

    def predict(self, img, topk=5) -> List[str]:
        img = make_horizontal(img)
        img = get_center_crop(img, 640, 480)

        tensor = torch.FloatTensor(img)[None, :, :, :]
        # print(tensor.shape)

        output = self.model(tensor)[0]
        output = torch.sigmoid(output)
        # print(output)

        values, indices = torch.topk(output, topk)
        values, indices = sort_tensors_based_on_first(values, indices)
        # print(indices)

        # Create a zeros tensor of the same shape
        mask = torch.zeros_like(output)
        # print(mask.shape)

        # Set the top 1 position to 1
        mask[indices] = 1
        # print(mask.view(1, -1).shape[1])

        ingredient_ids = self.mlb.inverse_transform(mask.view(1, -1))[0]
        # print(ingredient_ids)

        ingredient_names = [
            self.df.loc[self.df["id"] == id, "ingr"].values[0]
            for id in list(ingredient_ids)
        ]
        # print(ingredient_names)

        return ingredient_names
