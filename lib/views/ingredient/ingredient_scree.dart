import 'package:flutter/material.dart';
import 'package:tech_task/enums/ui_state_enum.dart';
import 'package:tech_task/models/baseViewModel/base_view_model.dart';
import 'package:tech_task/routes/view_routes.dart';
import 'package:tech_task/views/ingredient/ingredent_screen_view_model.dart';

class IngredientsScreen extends StatefulWidget {
  @override
  _IngredientsScreenState createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
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
            actions: [
              IconButton(
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.orange,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ],
            leading: SizedBox(),
            backgroundColor: Colors.blue,
            elevation: 0.0,
            title: Text(
              'Ingredients',
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
                    Text("Loading Ingredients"),
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                  ],
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Form to input the lunch date
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: provider.dateController,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            hintText: "Lunch Date: ${provider.lunchDate}"),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.allIngredients.length,
                        itemBuilder: (context, index) {
                          final ingredient = provider.allIngredients[index];
                          return Card(
                            child: CheckboxListTile(
                                value: provider.chosenIngredients
                                    .contains(ingredient),
                                onChanged: (value) {
                                  return provider.handleUnchanged(
                                      ingredient, value);
                                },
                                title: Text(
                                  ingredient.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                subtitle: Text(
                                  ingredient.useBy,
                                  style: TextStyle(fontSize: 16.0),
                                )
                                // value: false,
                                ),
                          );
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: !(provider.chosenIngredients.length == 0)
                          ? () => Navigator.pushNamed(
                              context, ViewRoutes.recipe,
                              arguments: provider.chosenIngredients)
                          : null,
                      child: provider.chosenIngredients.length == 0
                          ? Text(
                              "${provider.chosenIngredients.length} item selected!, Tap on card to select",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              "${provider.chosenIngredients.length} selected!, Tap me to see recipes",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 30,
                    )
                  ],
                ),
        );
      },
    );
  }
}
