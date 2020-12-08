import 'package:js_skill_up/constants/shared_prefs.dart';
import 'package:js_skill_up/main.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';
import 'package:js_skill_up/services/redux/reducers/user_reducer.dart';
import 'package:js_skill_up/utils/shared_prefs.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> saveLoginState(UserModel user) {
  return (Store<AppState> store) async {
    await SharedPrefsUtils.setValue(SharedPrefsConstants.UID, user?.uid);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.DISPLAY_NAME, user?.displayName);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.USER_EMAIL, user?.email);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.PHONE_NUMBER, user?.phoneNumber);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.PHOTO_URL, user?.photoURL);

    store.dispatch(SaveUserAction(user));
  };
}

ThunkAction<AppState> initialiseLoginState = (Store<AppState> store) async {
  final String uid = await SharedPrefsUtils.getValue(SharedPrefsConstants.UID);
  final displayName =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.DISPLAY_NAME);
  final String email =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.USER_EMAIL);
  final String phoneNumber =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.PHONE_NUMBER);
  final String photoUrl =
      await SharedPrefsUtils.getValue(SharedPrefsConstants.PHOTO_URL);

  if ((uid ?? "").length > 1) {
    store.dispatch(SaveUserAction(new UserModel(
        uid: uid,
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        photoURL: photoUrl)));
  } else {
    GlobalKeys.navKey.currentState.pushNamed(AppRoutes.login);
  }
};
