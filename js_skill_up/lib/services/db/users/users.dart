import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';

class UsersDB {
  static Future saveLoginInfo(UserModel userInfo) async {
    try {
      CollectionReference usersRef =
          FirebaseFirestoreUtils.getCollectionRef('users');
      await usersRef.add(userInfo.toMap());
      return true;
    } catch (e) {
      print('Failed saving user info to DB: \n $userInfo');
      return false;
    }
  }
}
