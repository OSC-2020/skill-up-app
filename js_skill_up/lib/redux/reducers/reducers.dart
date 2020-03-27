import 'package:js_skill_up/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/get_user_reducer.dart';

AppState appReducer(state, action) {
  return AppState(user: getUserReducer(state, action));
}
