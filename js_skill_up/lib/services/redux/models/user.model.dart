import 'package:js_skill_up/services/db/db_constants.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoURL;

  UserModel(
      {this.uid,
      this.displayName,
      this.email,
      this.phoneNumber,
      this.photoURL});

  factory UserModel.fromJson(Map<String, dynamic> userInfoMap) {
    return UserModel(
        uid: userInfoMap[FirestoreUserLevelCollections.UID_STRING],
        displayName:
            userInfoMap[FirestoreUserLevelCollections.DISPLAY_NAME_STRING],
        email: userInfoMap[FirestoreUserLevelCollections.EMAIL_STRING],
        phoneNumber:
            userInfoMap[FirestoreUserLevelCollections.PHONE_NUMBER_STRING],
        photoURL: userInfoMap[FirestoreUserLevelCollections.PHOTO_URL_STRING]);
  }

  toMap() {
    Map thisUser = new Map<String, dynamic>();
    thisUser[FirestoreUserLevelCollections.UID_STRING] = this.uid;
    thisUser[FirestoreUserLevelCollections.DISPLAY_NAME_STRING] =
        this.displayName;
    thisUser[FirestoreUserLevelCollections.EMAIL_STRING] = this.email;
    thisUser[FirestoreUserLevelCollections.PHONE_NUMBER_STRING] =
        this.phoneNumber;
    thisUser[FirestoreUserLevelCollections.PHOTO_URL_STRING] = this.photoURL;
    return thisUser;
  }
}
