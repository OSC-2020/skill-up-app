import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';

class BookDetailModel {
  final String id;
  final String title;
  final int totalChapters;
  final int chaptersCompleted;
  final List<ChapterDetailModel> chapters;

  BookDetailModel({
    this.id,
    this.title,
    this.totalChapters,
    this.chaptersCompleted,
    this.chapters,
  });
}
