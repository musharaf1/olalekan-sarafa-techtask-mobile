import 'package:flutter/material.dart';
import 'package:tech_task/core/routes/view_routes.dart';
import '../../../core/models/baseProviderModel/base_provider_model.dart';

class SplashScreenViewModel extends BaseProviderModel {
  Future startUp(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamed(context, ViewRoutes.ingredient);
  }
}
