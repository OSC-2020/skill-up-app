class UserModel {
  final String token;
  final String id;
  final String username;
  final String name;
  final String email;

  UserModel({this.id, this.token, this.username, this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token'], username: json['username']);
  }
}
