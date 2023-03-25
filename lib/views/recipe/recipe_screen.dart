import 'package:flutter/material.dart';
import 'package:tech_task/enums/ui_state_enum.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/models/baseViewModel/base_view_model.dart';
import 'package:tech_task/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/views/recipe/recipe_screen-view_model.dart';
import '../../models/recipeModel/recipe_model.dart';
import '../ingredient/ingredent_screen_view_model.dart';

class RecipeScreen extends StatefulWidget {
  final List<IngredientModel> ingredients;
  RecipeScreen(this.ingredients);
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

final ingredientProvider = myLocator<IngredientScreenViewModel>();

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseViewModel<RecipeScreenViewModel>(
      providerReady: (provider) {
        provider.getRecipes(widget.ingredients);
      },
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            elevation: 0.0,
            title: Text(
              'Recipes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: provider.state == ViewState.BUSY
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading recipes"),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ))
              : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(child: Image.asset("assets/images/recipeIcon.png")),
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.recipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        RecipeModel recipe = provider.recipes[index];
                        return Card(
                          elevation: 4.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            title: Text(
                              recipe.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Text(
                              recipe.ingredients.join(", "),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]),
        );
      },
    );
  }
}
