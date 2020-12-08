import 'package:flutter/material.dart';
import 'package:js_skill_up/screens/homepage/homepage.dart';
import 'package:js_skill_up/screens/login/login.dart';

class AppRoutes {
  static const String login = '/login';
  static const String homepage = '/homepage';
}

Route<dynamic> handleRoute(RouteSettings routeSettings) {
  List<String> nameParam = routeSettings.name.split(";");
  assert(nameParam.length >= 1);
  String routeName = nameParam[0];
  assert(routeName != null);
  Widget childWidget;
  switch (routeName) {
    case AppRoutes.login:
      childWidget = LoginScreen();
      break;
    case AppRoutes.homepage:
      childWidget = HomeScreen();
      break;
  }
  return MaterialPageRoute(builder: (context) => childWidget);
}
