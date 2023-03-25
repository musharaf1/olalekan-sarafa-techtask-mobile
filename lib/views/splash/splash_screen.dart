import 'package:flutter/material.dart';
import 'package:tech_task/views/splash/splash_screen_view_model.dart';

import '../../models/baseViewModel/base_view_model.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseViewModel<SplashScreenViewModel>(
      providerReady: (provider) {
        provider.startUp(context);
      },
      builder: (context, provider, _) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/recipeIcon.png',
              )
            ],
          ),
        ),
      ),
    );
  }
}
