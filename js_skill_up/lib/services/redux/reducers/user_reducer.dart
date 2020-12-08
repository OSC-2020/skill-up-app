import 'package:js_skill_up/services/redux/models/user_model.dart';

getUserReducer(UserModel user, dynamic action) {
  if (action is SaveUserAction) {
    return action.user;
  }
  return user;
}

class SaveUserAction {
  final UserModel _user;

  SaveUserAction(this._user);

  UserModel get user => this._user;
}
