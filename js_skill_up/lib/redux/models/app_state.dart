import 'package:flutter/foundation.dart';
import 'package:js_skill_up/redux/models/user_model.dart';

class AppState {
  UserModel user;

  AppState({@required this.user});

  factory AppState.initial() {
    return AppState(user: null);
  }
}
