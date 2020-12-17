import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/global_keys.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/screens/homepage/homepage.dart';
import 'package:js_skill_up/services/redux/middleware/login_state_middleware.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/reducers/app_reducers.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

bool USE_FIRESTORE_EMULATOR = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  if (USE_FIRESTORE_EMULATOR) {
    FirebaseFirestore.instance.settings = Settings(
        host: 'localhost:8080', sslEnabled: false, persistenceEnabled: false);
  }
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
        home: HomeScreen(
          checkUserLogin: () =>
              _store.dispatch(initialiseLoginStateMiddlewareAction),
        ),
        onGenerateRoute: handleRoute,
        navigatorKey: GlobalKeys.navKey,
      ),
    );
  }
}
