import 'package:flutter/foundation.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';

@immutable
class AppState {
  final UserModel user;
  final BookInfoModel currentBook;
  final ChapterInfoModel currentChapterInfo;
  final ChapterDetailModel currentChapterDetail;

  AppState(
      {@required this.user,
      this.currentBook,
      this.currentChapterInfo,
      this.currentChapterDetail});

  factory AppState.initial() {
    return AppState(
      user: null,
      currentBook: null,
      currentChapterInfo: null,
      currentChapterDetail: null,
    );
  }
}
