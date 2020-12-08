import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/reducers/path_detail_reducer.dart';
import 'package:js_skill_up/services/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: getUserReducer(state.user, action),
    currentPath: pathDetailReducer(state.currentPath, action),
  );
}