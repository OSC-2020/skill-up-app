import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';

class ChaptersDB {
  static CollectionReference getChaptersRef(String bookID) {
    return FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOKS)
        .doc(bookID)
        .collection(FirestoreBooksLevelCollections.COLLECTION_CHAPTERS);
  }

  static Future<DocumentSnapshot> getChapterInfo(
      String bookID, String chapterID) {
    return ChaptersDB.getChaptersRef(bookID).doc(chapterID).get();
  }

  static Future<List> getChapterContents(
      String bookID, String chapterID) async {
    QuerySnapshot contentSnapshot = await ChaptersDB.getChaptersRef(bookID)
        .doc(chapterID)
        .collection(
            FirestoreChaptersLevelConstants.COLLECTION_CHAPTERS_CONTENTS)
        .get();
    List content = new List();
    contentSnapshot.docs.forEach((element) {
      content.add(element.data());
    });
    return content;
  }

  static markChapterCompleted(String bookID, String chapterID) async {
    DocumentReference chapterRef =
        ChaptersDB.getChaptersRef(bookID).doc(chapterID);
    DocumentReference bookRef = FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOKS)
        .doc(bookID);

    FirebaseFirestoreUtils.runInTransaction((transaction) async {
      await transaction.get(chapterRef);
      DocumentSnapshot dataSnap = await transaction.get(bookRef);

      transaction.update(chapterRef,
          {FirestoreChaptersLevelConstants.IS_COMPLETED_BOOL: true});

      var bookData = dataSnap.data();
      transaction.update(bookRef, {
        FirestoreBooksLevelCollections.CHAPTERS_COMPLETED_INT: bookData
                .containsKey(
                    FirestoreBooksLevelCollections.CHAPTERS_COMPLETED_INT)
            ? bookData[FirestoreBooksLevelCollections.CHAPTERS_COMPLETED_INT] +
                1
            : 1
      });

      List chapters = bookData[FirestoreBooksLevelCollections.CHAPTERS_ARRAY];
      var found = chapters.firstWhere((chapter) =>
          chapter[FirestoreBooksLevelCollections.CHAPTER_ID_STRING] ==
          chapterID);
      found[FirestoreBooksLevelCollections.IS_COMPLETED_BOOL] = true;
      transaction.update(
          bookRef, {FirestoreBooksLevelCollections.CHAPTERS_ARRAY: chapters});
    });
  }
}
