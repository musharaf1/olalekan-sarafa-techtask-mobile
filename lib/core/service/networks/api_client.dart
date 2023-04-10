import 'package:tech_task/core/enums/ui_state_enum.dart';
import 'package:tech_task/core/models/baseProviderModel/base_provider_model.dart';
import 'package:dio/dio.dart';
import 'package:tech_task/core/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/core/models/recipeModel/recipe_model.dart';

class ApiClient extends BaseProviderModel {
  final String baseUrl =
      "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";

  Future<List<RecipeModel>> getRecipes(
      List<IngredientModel> ingredients) async {
    String queryParam =
        ingredients.map((ingredient) => "<<$ingredient.title>>").join(", ");
    Map<String, String> _queryParams = {"ingredients": queryParam};
    print(_queryParams);

    try {
      setViewState(ViewState.BUSY);
      final response =
          await Dio().get('$baseUrl/recipes', queryParameters: _queryParams);
      setViewState(ViewState.IDLE);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<RecipeModel> recipes =
            data.map((e) => RecipeModel.fromJson(e)).toList();
        print(recipes);

        return recipes;
      }
      return [];
    } catch (error) {
      setViewState(ViewState.IDLE);
      print('Error fetching recipes: $error');
      throw error;
    }
  }

  Future<List<IngredientModel>> getIngredients() async {
    try {
      final response = await Dio().get('$baseUrl/ingredients');
      setViewState(ViewState.IDLE);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final List<IngredientModel> ingredients =
            data.map((e) => IngredientModel.fromJson(e)).toList();

        return ingredients;
      }
      return [];
    } catch (error) {
      setViewState(ViewState.IDLE);
      print('Error fetching ingredients: $error');
      throw error;
    }
  }
}
