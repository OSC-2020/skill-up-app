import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';

class BookChapterDB {
  static Future<DocumentSnapshot> getAllChapters(String bookID) {
    return FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOKS)
        .doc(bookID)
        .get();
  }
}
