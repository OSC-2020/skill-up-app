import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/models/app_state.model.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_content.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/reducers/chapter_detail.reducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> loadChapterDetailFromDBMiddleware(
    String bookID, String chapterID) {
  return (Store<AppState> store) async {
    DocumentSnapshot chapterDoc =
        await ChaptersDB.getChapterInfo(bookID, chapterID);
    ChapterDetailModel chapter = ChapterDetailModel.fromMap(chapterDoc.data());
    List contents = await ChaptersDB.getChapterContents(bookID, chapterID);

    chapter = chapter.copyWith(
        contents: contents
            .map((e) => ChapterTheoryModel.fromMap(e))
            .toList(growable: false));
    store.dispatch(ChapterDetailSaveToStoreAction(chapter: chapter));
  };
}
