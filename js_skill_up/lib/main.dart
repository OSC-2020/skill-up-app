import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/app_reducers.dart';
import 'package:js_skill_up/screens/homepage.dart';
import 'package:js_skill_up/screens/login.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial());

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> _store;

  MyApp(this._store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: this._store,
      child: MaterialApp(
        title: 'js Skill Up',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF4ECDC4),
          primaryColorDark: Color(0xFF1A535C),
          accentColor: Color(0xFFFF6B6B),
        ),
        home: LoginScreen(),
        routes: {
          '/login': (BuildContext context) => LoginScreen(),
          '/homepage': (BuildContext context) => HomeScreen()
        },
      ),
    );
  }
}
