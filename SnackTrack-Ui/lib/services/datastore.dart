import 'dart:io';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';

class Datastore {
  final _dio = Dio(BaseOptions(baseUrl: 'http://10.51.1.71:80/', headers: {
    'Content-Type': 'application/json',
  }));

  Future<List<String>> getSuggestions(XFile img) async {
    List<String> ingredients = [];
    File file = File(img.path);
    final imageBytes = file.readAsBytesSync();
    final base64Image = base64Encode(imageBytes);

    final response = await _dio.post('/ingredients-suggestion', data: {
      'base64File': base64Image,
    });

    for (var ingredient in response.data) {
      if (ingredients.contains(ingredient)) {
        continue;
      }

      ingredients.add(ingredient);
    }

    return ingredients;
  }

  Future<List<String>> getNutritions(
    XFile img,
    List<String> ingredients,
  ) async {
    File file = File(img.path);
    List<String> nutritionalData = [];
    final imageBytes = file.readAsBytesSync();
    final base64Image = base64Encode(imageBytes);

    final response = await _dio.post('/nutritional-data', data: {
      'base64File': base64Image,
      'ingredients': ingredients,
    });

    for (var nutrition in response.data.entries) {
      final name_splits = nutrition.key.toString().split('_');
      String name = name_splits[0];
      name = name[0].toUpperCase() + name.substring(1);
      double value = nutrition.value;
      String unit = '';

      if (name_splits[name_splits.length - 1] == 'g' ||
          name_splits[name_splits.length - 1] == 'mg') {
        unit = name_splits[name_splits.length - 1];
      }

      nutritionalData.add('$name: $value $unit');
    }
    // final response = await _dio.post('/nutritions', data: formData);
    return nutritionalData;
  }
}
