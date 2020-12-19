import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';

ChapterInfoModel bookChaptersReducer(ChapterInfoModel chapter, dynamic action) {
  if (action is BookChaptersSelectChapterAction) {
    return action.selectedChapter;
  }
  return chapter;
}

class BookChaptersSelectChapterAction {
  ChapterInfoModel selectedChapter;

  BookChaptersSelectChapterAction({this.selectedChapter});
}
