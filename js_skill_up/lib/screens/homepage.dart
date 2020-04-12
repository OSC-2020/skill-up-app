import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserModel>(
      converter: (store) => store.state.user,
      builder: (context, UserModel user) {
        return Container(
          color: Theme.of(context).accentColor,
          child: Center(
            child: Text(user.username),
          ),
        );
      },
    );
  }
}
