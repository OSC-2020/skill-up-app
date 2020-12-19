import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';

class ChaptersDB {
  static CollectionReference getChaptersRef(String bookID, String chapterID) {
    return FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOKS)
        .doc(bookID)
        .collection(FirestoreBooksLevelCollections.CHAPTERS);
  }

  static Future<DocumentSnapshot> getChapterInfo(
      String bookID, String chapterID) {
    return ChaptersDB.getChaptersRef(bookID, chapterID).doc(chapterID).get();
  }

  static Future<List> getChapterContents(
      String bookID, String chapterID) async {
    QuerySnapshot contentSnapshot =
        await ChaptersDB.getChaptersRef(bookID, chapterID)
            .doc(chapterID)
            .collection(FirestoreChapterLevelCollections.CHAPTERS_CONTENT)
            .get();
    List content = new List();
    contentSnapshot.docs.forEach((element) {
      content.add(element.data());
    });
    return content;
  }
}
