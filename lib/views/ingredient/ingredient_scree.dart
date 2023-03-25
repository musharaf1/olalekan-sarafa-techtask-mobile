import 'package:flutter/material.dart';
import 'package:tech_task/models/baseViewModel/base_view_model.dart';
import 'package:tech_task/views/ingredient/ingredent_screen_view_model.dart';

class IngredientsScreen extends StatefulWidget {
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BaseViewModel<IngredientScreenViewModel>(
      providerReady: (provider) {
        provider.handleSubmit();
      },
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Recipe App'),
          ),
          body:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: size.height / 40,
            ),
            Text("Launch date"),
            // Form to input the lunch date
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: provider.dateController,
                decoration:
                    InputDecoration(hintText: provider.lunchDate.toString()),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: provider.allIngredients.length,
                itemBuilder: (context, index) {
                  final ingredient = provider.allIngredients[index];
                  return CheckboxListTile(
                      value: provider.chosenIngredients.contains(ingredient),
                      onChanged: (value) {
                        return provider.handleUnchanged(ingredient, value);
                      },
                      title: Text(ingredient.title),
                      subtitle: Text(ingredient.useBy)
                      // value: false,
                      );
                },
              ),
            )
          ]),
        );
      },
    );
  }
}
