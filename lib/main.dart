import 'package:flutter/material.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/routes/routes.dart' as router;
import 'package:tech_task/routes/view_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpMyLocator();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      onGenerateRoute: router.Router.generateRoute,
      initialRoute: ViewRoutes.splash,
    );
  }
}
