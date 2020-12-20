import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_chapters.reducer.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_groups.reducer.dart';
import 'package:js_skill_up/services/redux/reducers/books/current_book.reducer.dart';
import 'package:js_skill_up/services/redux/reducers/books/current_chapter.reducer.dart';
import 'package:js_skill_up/services/redux/reducers/chapter_detail_reducer.dart';
import 'package:js_skill_up/services/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    user: getUserReducer(state.user, action),
    bookGroups: bookGroupsReducer(state.bookGroups, action),
    currentBook: currentBookReducer(state.currentBook, action),
    bookChaptersMap: bookChaptersReducer(state.bookChaptersMap, action),
    currentChapterInfo: currentChapterReducer(state.currentChapterInfo, action),
    currentChapterDetail:
        chapterDetailReducer(state.currentChapterDetail, action),
  );
}
