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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json['uid'],
        displayName: json['displayName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        photoURL: json['photoURL']);
  }

  toMap() {
    Map thisUser = new Map<String, dynamic>();
    thisUser['uid'] = this.uid;
    thisUser['displayName'] = this.displayName;
    thisUser['email'] = this.email;
    thisUser['phoneNumber'] = this.phoneNumber;
    thisUser['photoURL'] = this.photoURL;
    return thisUser;
  }
}
