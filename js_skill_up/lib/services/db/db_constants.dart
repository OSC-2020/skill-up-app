int STANDARD_FETCH_LIMIT = 5;

class FirestoreRootLevelCollections {
  static String USERS = 'users';
  static String BOOK_GROUPS = 'book_groups';
  static String BOOKS = 'books';
}

class FirestoreBooksLevelCollections {
  static String CHAPTERS = 'chapters';
}

class FirestoreChapterLevelCollections {
  static String CHAPTERS = 'chapters';
  static String CHAPTERS_CONTENT = 'contents';
}
