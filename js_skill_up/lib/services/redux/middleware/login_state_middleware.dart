import 'package:js_skill_up/global_keys.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';
import 'package:js_skill_up/services/redux/reducers/user_reducer.dart';
import 'package:js_skill_up/services/shared_prefs/user.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> saveLoginStateMiddlewareAction(UserModel user) {
  return (Store<AppState> store) async {
    await SP_User.saveUserInfo(user);
    store.dispatch(SaveUserAction(user));
  };
}

ThunkAction<AppState> initialiseLoginStateMiddlewareAction =
    (Store<AppState> store) async {
  final savedUser = await SP_User.getSavedUser();

  if ((savedUser.uid ?? "").length > 1) {
    store.dispatch(SaveUserAction(savedUser));
  } else {
    GlobalKeys.navKey.currentState.pushNamed(AppRoutes.LOGIN);
  }
};
