import 'package:js_skill_up/services/redux/models/books/book_groups.model.dart';

List<BookGroupsModel> bookGroupsReducer(
    List<BookGroupsModel> groups, dynamic action) {
  if (action is BookGroupsSaveToStoreFromDBBookAction) {
    return action.groups;
  }
  return groups;
}

class BookGroupsSaveToStoreFromDBBookAction {
  List<BookGroupsModel> groups;

  BookGroupsSaveToStoreFromDBBookAction({this.groups});
}
