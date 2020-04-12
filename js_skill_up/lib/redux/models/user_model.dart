class UserModel {
  final String token;
  final String id;
  final String username;

  UserModel({this.id, this.token, this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token'], username: json['username']);
  }
}
