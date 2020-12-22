import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/books/book_groups.dart';
import 'package:js_skill_up/services/redux/models/app_state.model.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.model.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_groups.reducer.dart';
import 'package:redux/redux.dart';

void loadBookGroupsFromDBMiddleware(Store<AppState> store) async {
  QuerySnapshot groupsSnapshot = await BookGroupsDB.getAllBookGroups();
  List<BookGroupsModel> bookGroups = new List<BookGroupsModel>();
  groupsSnapshot.docs.forEach((doc) {
    bookGroups.add(BookGroupsModel.fromMap(doc.data()));
  });

  store.dispatch(BookGroupsSaveToStoreFromDBBookAction(groups: bookGroups));
}
