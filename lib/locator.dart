import 'package:get_it/get_it.dart';
import 'package:tech_task/service/networks/api_client.dart';
import 'package:tech_task/views/ingredient/ingredent_screen_view_model.dart';
import 'package:tech_task/views/recipe/recipe_screen-view_model.dart';
import 'package:tech_task/views/splash/splash_screen_view_model.dart';

GetIt myLocator = GetIt.instance;

void setUpMyLocator() {
  myLocator.registerLazySingleton(() => ApiClient());
  myLocator.registerLazySingleton(() => RecipeScreenViewModel());
  myLocator.registerLazySingleton(() => IngredientScreenViewModel());
  myLocator.registerLazySingleton(() => SplashScreenViewModel());
}
