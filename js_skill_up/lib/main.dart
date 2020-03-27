import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/reducers.dart';
import 'package:js_skill_up/screens/login.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: []);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: this.store,
      child: MaterialApp(
          title: 'js Skill Up',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color(0xFF4ECDC4),
              primaryColorDark: Color(0xFF1A535C),
              accentColor: Color(0xFFFF6B6B)),
          home: LoginScreen()),
    );
  }
}
