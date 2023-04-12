import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/core/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/core/service/networks/api_client.dart';
import '../../../core/enums/ui_state_enum.dart';
import '../../../core/models/baseProviderModel/base_provider_model.dart';

class IngredientScreenViewModel extends BaseProviderModel {
  final _apiClient = myLocator<ApiClient>();

  List<IngredientModel> chosenIngredients = [];

  List<IngredientModel> _ingredients = [];

  List<IngredientModel> get allIngredients => _ingredients;

  bool isIngredientExpired(IngredientModel ingredient, {String lunchTime}) {
    final now = DateTime.now();
    final useByDate = DateFormat("yyyy-MM-dd").parse(ingredient.useBy);

    if (lunchTime != null) {
      final _lunchTime = DateFormat("yyyy-MM-dd").parse(lunchTime);
      return useByDate.isBefore(_lunchTime) ||
          useByDate.isAtSameMomentAs(_lunchTime);
    }

    return useByDate.isBefore(now) || useByDate.isAtSameMomentAs(now);
  }

  var hintTextLunchDate;

  void handleSubmit(final _dateController) async {
    // If the input is empty, set the date to today's date
    final date = _dateController.text.isEmpty
        ? DateTime.now()
        : DateTime.parse(_dateController.text);
    hintTextLunchDate = date.toString().split(" ").first.toString();
  }

  void getIngredients() async {
    chosenIngredients = [];
    setViewState(ViewState.BUSY);

    _ingredients = await _apiClient.getIngredients();

    setViewState(ViewState.IDLE);
  }

  void handleUnchanged(IngredientModel ingredient, bool value, bool isExpired,
      final _dateController, final context) {
    updateDate(_dateController);
    if (value && !isExpired) {
      chosenIngredients.add(ingredient);
    } else {
      if (!chosenIngredients.contains(ingredient))
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "The ${ingredient.title} is expired and cannot be selected."),
        ));
      chosenIngredients.remove(ingredient);
    }
    notifyListeners();
  }

  var initialDate = '';
  updateDate(TextEditingController _dateController) {
    initialDate =
        _dateController.text.isEmpty ? hintTextLunchDate : _dateController.text;
  }
}
