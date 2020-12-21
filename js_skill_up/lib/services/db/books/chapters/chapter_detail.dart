import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';

class ChaptersDB {
  static CollectionReference getChaptersRef(String bookID) {
    return FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOKS)
        .doc(bookID)
        .collection(FirestoreBooksLevelCollections.CHAPTERS);
  }

  static Future<DocumentSnapshot> getChapterInfo(
      String bookID, String chapterID) {
    return ChaptersDB.getChaptersRef(bookID).doc(chapterID).get();
  }

  static Future<List> getChapterContents(
      String bookID, String chapterID) async {
    QuerySnapshot contentSnapshot = await ChaptersDB.getChaptersRef(bookID)
        .doc(chapterID)
        .collection(FirestoreChapterLevelCollections.CHAPTERS_CONTENT)
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

      transaction.update(chapterRef, {'isCompleted': true});

      var data = dataSnap.data();
      transaction.update(bookRef, {
        'chaptersCompleted': data.containsKey('chaptersCompleted')
            ? data['chaptersCompleted'] + 1
            : 1
      });

      List chapters = data['chapters'];
      var found = chapters.firstWhere((chapter) => chapter['id'] == chapterID);
      found['isCompleted'] = true;
      transaction.update(bookRef, {'chapters': chapters});
    });
  }
}
