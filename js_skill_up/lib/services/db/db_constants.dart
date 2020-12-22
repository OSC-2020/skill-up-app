int STANDARD_FETCH_LIMIT = 5;

class FirestoreRootLevelCollections {
  static String USERS = 'users';
  static String BOOK_GROUPS = 'book_groups';
  static String BOOKS = 'books';
}

class FirestoreUserLevelCollections {
  static final String UID_STRING = 'uid';
  static final String DISPLAY_NAME_STRING = 'displayName';
  static final String EMAIL_STRING = 'email';
  static final String PHONE_NUMBER_STRING = 'phoneNumber';
  static final String PHOTO_URL_STRING = 'photoURL';
}

class FirestoreBookGroupsLevelCollections {
  static final String TITLE_STRING = 'title';
  static final String UI_TYPE_INT = 'uiType';
  static final String BOOK_ID_STRING = 'id';
  static final String BOOKS_ARRAY = 'books';
}

class FirestoreBooksLevelCollections {
  static final String COLLECTION_CHAPTERS = 'chapters';
  static final String CHAPTERS_ARRAY = 'chapters';
  static final String ID_STRING = 'id';
  static final String TITLE_STRING = 'title';
  static final String TOTAL_CHAPTERS_INT = 'totalChapters';
  static final String CHAPTERS_COMPLETED_INT = 'chaptersCompleted';
  static final String IS_COMPLETED_BOOL = 'isCompleted';
  static final String CHAPTER_ID_STRING = 'id';
}

class FirestoreChaptersLevelConstants {
  static final String COLLECTION_CHAPTERS_CONTENTS = 'contents';
  static final String IS_COMPLETED_BOOL = 'isCompleted';
}

class FirestoreChaptersContentLevelConstants {
  static final String CONTENT_STRING = 'content';
  static final String CONTENT_TEXT_STRING = 'contentText';
  static final String CONTENT_TYPE_INT = 'contentType';
  static final String PAGE_TYPE_INT = 'pageType';
  static final String FOOTER_HELP_TEXT_STRING = 'footerHelpText';
}
