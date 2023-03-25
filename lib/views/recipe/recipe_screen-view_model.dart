import 'package:tech_task/locator.dart';
import 'package:tech_task/models/recipeModel/recipe_model.dart';
import 'package:tech_task/service/networks/api_client.dart';
import '../../models/baseProviderModel/base_provider_model.dart';

class RecipeScreenViewModel extends BaseProviderModel {
  final _apiClient = myLocator<ApiClient>();

  List<RecipeModel> _recipes = [];

  List<RecipeModel> get recipes => _recipes;
}
