import 'package:json_annotation/json_annotation.dart';

class IngredientModel {
  final String title;
  @JsonKey(name: 'use-by')
  final String useBy;

  IngredientModel({this.useBy, this.title});

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        title: json["title"],
        useBy: json["use-by"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "useBy": useBy,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IngredientModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          useBy == other.useBy;

  @override
  int get hashCode => title.hashCode ^ useBy.hashCode;
}
