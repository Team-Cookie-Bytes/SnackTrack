from typing import List
from fastapi import FastAPI, File, Form, UploadFile
from pydantic import BaseModel

app = FastAPI()


class MassPrediction(BaseModel):
    ingredient: str
    mass: float


class Body(BaseModel):
    base64image: str
    ingredients: List[str]


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.post("/mass-prediction")
async def get_mass_prediction(body: Body) -> List[MassPrediction]:
    print(body.base64image, body.ingredients)
    return [MassPrediction(ingredient=i, mass=13) for i in body.ingredients]
