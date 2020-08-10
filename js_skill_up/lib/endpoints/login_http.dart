import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:js_skill_up/config/prod.dart';
import 'package:js_skill_up/redux/models/user_model.dart';

class LoginEndPoints {
  final _loginUrl = "${AppConfig.BASE_URL}\app_login";

  Future<UserModel> loginToApp() async {
    http.Response res = await http.post(_loginUrl, body: {'name': 'doodle'});
    if (res.statusCode == 200) {
      return UserModel.fromJson(json.decode(res.body));
    }
    throw Exception("Failed to login the user");
  }
}
