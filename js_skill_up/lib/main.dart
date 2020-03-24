import 'package:flutter/material.dart';
import 'package:js_skill_up/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'js Skill Up',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Color(0xFFF7FFF7),
            primaryColor: Color(0xFF4ECDC4),
            primaryColorDark: Color(0xFF1A535C),
            accentColor: Color(0xFF6B6B)
            ),
        home: LoginScreen());
  }
}
