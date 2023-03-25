import 'package:flutter/material.dart';
import 'package:tech_task/models/baseViewModel/base_view_model.dart';
import 'package:tech_task/views/recipe/recipe_screen-view_model.dart';

class RecipeScreen extends StatefulWidget {
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseViewModel<RecipeScreenViewModel>(
      providerReady: (provider) {},
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Recipe App'),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Form to input the lunch date
          ]),
        );
      },
    );
  }
}
