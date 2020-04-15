import 'package:js_skill_up/constants/shared_prefs.dart';
import 'package:js_skill_up/main.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/user_model.dart';
import 'package:js_skill_up/redux/reducers/user_reducer.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/utils/shared_prefs.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> saveLoginState(UserModel user) {
  return (Store<AppState> store) async {
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.USER_TOKEN, user?.token);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.USER_EMAIL, user?.email);
    await SharedPrefsUtils.setValue(SharedPrefsConstants.USER_NAME, user?.name);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.USER_USERNAME, user?.username);

    store.dispatch(SaveUserAction(user));
  };
}

ThunkAction<AppState> initialiseLoginState = (Store<AppState> store) async {
  final String token =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.USER_TOKEN);
  final email =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.USER_EMAIL);
  final name = await SharedPrefsUtils.getValue(SharedPrefsConstants.USER_NAME);

  //TODO: better logic for token check when backend will be integrated
  if (token.length > 1) {
    store.dispatch(
        SaveUserAction(new UserModel(token: token, email: email, name: name)));
  } else {
    GlobalKeys.navKey.currentState.pushNamed(AppRoutes.login);
  }
};
