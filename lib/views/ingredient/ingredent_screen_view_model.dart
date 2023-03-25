import 'package:flutter/material.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/service/networks/api_client.dart';
import '../../models/baseProviderModel/base_provider_model.dart';

class IngredientScreenViewModel extends BaseProviderModel {
  final _apiClient = myLocator<ApiClient>();

  List<IngredientModel> chosenIngredients = [
    IngredientModel(title: 'test', useBy: 'test')
  ];

  List<IngredientModel> _ingredients = [];

  List<IngredientModel> get allIngredients => _ingredients;

  TextEditingController _dateController = TextEditingController();
  TextEditingController get dateController => _dateController;

  // Function to check if an ingredient is past its "use-by" date
  bool isIngredientExpired(IngredientModel ingredient) {
    final now = DateTime.now();
    final useByDate = DateTime.parse(ingredient.useBy);
    return now.isAfter(useByDate) || now.isAtSameMomentAs(useByDate);
  }

  DateTime lunchDate;

  // Function to handle the submission of the lunch date form
  void handleSubmit() async {
    // If the input is empty, set the date to today's date
    final date = _dateController.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(_dateController.text);

    lunchDate = date;
    print(lunchDate);

    _ingredients = await _apiClient.getIngredients();
    notifyListeners();
    print(_ingredients.first.title);
  }

  void handleUnchanged(IngredientModel ingredient, bool value) {
    if (value && !isIngredientExpired(ingredient)) {
      chosenIngredients.add(ingredient);
      print("adds ingredient");
    } else {
      chosenIngredients.remove(ingredient);
      print("remove ingredient");
    }
    notifyListeners();
  }
}
