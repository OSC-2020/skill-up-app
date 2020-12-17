import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_groups.dart';
import 'package:js_skill_up/services/redux/reducers/chapter_detail_reducer.dart';
import 'package:js_skill_up/services/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: getUserReducer(state.user, action),
    currentBook: bookGroupsReducer(state.currentBook, action),
    currentChapter: chapterDetailReducer(state.currentChapter, action),
  );
}
