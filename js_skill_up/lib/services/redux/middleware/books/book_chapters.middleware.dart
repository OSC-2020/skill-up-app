import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/books/book_chapters.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/books/book_detail.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_chapters.reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> loadChaptersForBookFromDBMiddleware(String bookID) {
  return (Store<AppState> store) async {
    DocumentSnapshot chapterDoc = await BookChapterDB.getAllChapters(bookID);
    BookDetailModel bookDetail = new BookDetailModel.fromMap(chapterDoc.data());

    store.dispatch(BookChaptersSaveToStoreAction(
      bookID: bookID,
      bookDetail: bookDetail,
    ));
  };
}
