import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/firebase/firestore_utils.dart';

class BookGroupsDB {
  static Future<QuerySnapshot> getAllBookGroups() {
    return FirebaseFirestoreUtils.getCollectionRef(
            FirestoreRootLevelCollections.BOOK_GROUPS)
        .limit(STANDARD_FETCH_LIMIT)
        .get();
  }
}
