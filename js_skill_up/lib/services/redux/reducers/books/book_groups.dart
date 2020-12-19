import 'package:js_skill_up/services/redux/models/books/book_groups.dart';

BookInfoModel bookGroupsReducer(BookInfoModel book, dynamic action) {
  if (action is BookGroupSelectBookAction) {
    return action.selectedBook;
  }
  return book;
}

class BookGroupSelectBookAction {
  BookInfoModel selectedBook;

  BookGroupSelectBookAction({this.selectedBook});
}
