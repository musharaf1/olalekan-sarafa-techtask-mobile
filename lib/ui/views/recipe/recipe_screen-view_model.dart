import 'package:tech_task/core/enums/ui_state_enum.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/core/models/recipeModel/recipe_model.dart';
import 'package:tech_task/core/service/networks/api_client.dart';
import '../../../core/models/baseProviderModel/base_provider_model.dart';
import '../../../core/models/ingredientModel/ingredients_model.dart';

class RecipeScreenViewModel extends BaseProviderModel {
  final _apiClient = myLocator<ApiClient>();

  List<RecipeModel> _recipes = [];

  List<RecipeModel> get recipes => _recipes;

  void getRecipes(List<IngredientModel> ingredients) async {
    setViewState(ViewState.BUSY);
    _recipes = await _apiClient.getRecipes(ingredients);
    setViewState(ViewState.IDLE);
  }
}
