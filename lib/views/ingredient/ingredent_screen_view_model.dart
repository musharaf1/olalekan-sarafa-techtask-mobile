import 'package:flutter/material.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/service/networks/api_client.dart';
import '../../enums/ui_state_enum.dart';
import '../../models/baseProviderModel/base_provider_model.dart';

class IngredientScreenViewModel extends BaseProviderModel {
  final _apiClient = myLocator<ApiClient>();

  List<IngredientModel> chosenIngredients = [];

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

  // bool isIngredientExpired(IngredientModel ingredient, {String lunchTime}) {
  //   final now = DateTime.now();
  //   final useByDate = DateTime.parse(ingredient.useBy);
  //   // final _lunchTime = DateTime.parse(lunchTime);

  //   if (lunchTime != null) {
  //     return _lunchTime.isAfter(useByDate) ||
  //         _lunchTime.isAtSameMomentAs(useByDate);
  //   }

  //   return now.isAfter(useByDate) || now.isAtSameMomentAs(useByDate);
  // }

  var hintTextLunchDate, lunchDate;

  // Function to handle the submission of the lunch date form
  void handleSubmit() async {
    // If the input is empty, set the date to today's date
    final date = _dateController.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(_dateController.text);

    // lunchDate = date.toString().split(" ").first.toString();

    hintTextLunchDate = date.toString().split(" ").first.toString();
  }

  void getIngredients() async {
    chosenIngredients = [];
    setViewState(ViewState.BUSY);

    _ingredients = await _apiClient.getIngredients();
    setViewState(ViewState.IDLE);
  }

  void handleUnchanged(IngredientModel ingredient, bool value, bool isExpired) {
    if (value) {
      chosenIngredients.add(ingredient);
      print("adds ingredient");
      print(chosenIngredients.length);
    } else {
      chosenIngredients.remove(ingredient);
      print("remove ingredient");
    }
    notifyListeners();
  }
}
