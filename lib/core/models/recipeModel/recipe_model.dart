class RecipeModel {
  String title;
  List<String> ingredients;

  RecipeModel({this.title, this.ingredients});

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      title: json['title'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}
