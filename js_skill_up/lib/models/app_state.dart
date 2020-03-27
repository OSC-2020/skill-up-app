import 'package:flutter/foundation.dart';

class AppState {
  dynamic user;

  AppState({@required this.user});

  factory AppState.initial(){
    return AppState(user: null);
  }

  factory AppState.fromAnotherState(AppState another) {
    AppState appState = new AppState.initial();
    appState.user = another.user;
    return appState;
  }
}
