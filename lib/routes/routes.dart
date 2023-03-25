import 'package:flutter/material.dart';
import 'package:tech_task/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/routes/view_routes.dart';
import 'package:tech_task/views/ingredient/ingredient_scree.dart';
import 'package:tech_task/views/splash/splash_screen.dart';

import '../views/recipe/recipe_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ViewRoutes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case ViewRoutes.ingredient:
        return MaterialPageRoute(builder: (_) => IngredientsScreen());

      case ViewRoutes.recipe:
        final List<IngredientModel> ingredients =
            settings.arguments as List<IngredientModel>;
        return MaterialPageRoute(builder: (_) => RecipeScreen(ingredients));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No Route define for ${settings.name}'),
                  ),
                ));
    }
  }
}
