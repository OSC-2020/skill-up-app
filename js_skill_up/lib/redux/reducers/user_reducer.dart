import 'package:js_skill_up/redux/models/user_model.dart';

getUserReducer(UserModel user, dynamic action) {
  if (action is GetUserAction) {
    print(action.user.username);
    return action.user;
  }
  return user;
}

class GetUserAction {
  final UserModel _user;

  GetUserAction(this._user);

  UserModel get user => this._user;
}
