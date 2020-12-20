import 'package:js_skill_up/services/redux/models/books/book_detail.dart';

Map<String, BookDetailModel> bookChaptersReducer(
    Map<String, BookDetailModel> bookChapters, dynamic action) {
  if (action is BookChaptersSaveToStoreAction) {
    return new Map<String, BookDetailModel>.from(bookChapters)
      ..addAll({action.bookID: action.bookDetail});
  }
  return bookChapters;
}

class BookChaptersSaveToStoreAction {
  final String bookID;
  final BookDetailModel bookDetail;

  BookChaptersSaveToStoreAction({this.bookID, this.bookDetail});
}
