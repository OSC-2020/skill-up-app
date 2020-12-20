import 'package:js_skill_up/constants/shared_prefs.dart';
import 'package:js_skill_up/services/redux/models/user.model.dart';
import 'package:js_skill_up/utils/shared_prefs.dart';

class SP_User {
  static Future<UserModel> getSavedUser() async {
    final String uid =
        await SharedPrefsUtils.getValue(SharedPrefsConstants.UID);
    final displayName =
        await SharedPrefsUtils.getValue(SharedPrefsConstants.DISPLAY_NAME);
    final String email =
        await SharedPrefsUtils.getValue(SharedPrefsConstants.USER_EMAIL);
    final String phoneNumber =
        await SharedPrefsUtils.getValue(SharedPrefsConstants.PHONE_NUMBER);
    final String photoUrl =
        await SharedPrefsUtils.getValue(SharedPrefsConstants.PHOTO_URL);
    return new UserModel(
        uid: uid,
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        photoURL: photoUrl);
  }

  static Future saveUserInfo(UserModel user) async {
    await SharedPrefsUtils.setValue(SharedPrefsConstants.UID, user?.uid);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.DISPLAY_NAME, user?.displayName);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.USER_EMAIL, user?.email);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.PHONE_NUMBER, user?.phoneNumber);
    await SharedPrefsUtils.setValue(
        SharedPrefsConstants.PHOTO_URL, user?.photoURL);
  }
}
