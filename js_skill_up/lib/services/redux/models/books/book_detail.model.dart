import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';

class BookDetailModel {
  final String id;
  final String title;
  final int totalChapters;
  final int chaptersCompleted;
  final List<ChapterInfoModel> chapters;

  BookDetailModel({
    this.id,
    this.title,
    this.totalChapters,
    this.chaptersCompleted,
    this.chapters,
  });

  factory BookDetailModel.fromMap(Map data) {
    List<ChapterInfoModel> chapters =
        (data.containsKey('chapters') && (data['chapters'] is List))
            ? data['chapters']
                .map<ChapterInfoModel>(
                    (chapter) => ChapterInfoModel.fromDynamicJson(chapter))
                .toList()
            : null;
    return BookDetailModel(
      id: data['id'],
      title: data['title'],
      totalChapters: data['totalChapters'],
      chaptersCompleted: data['chaptersCompleted'],
      chapters: chapters,
    );
  }
}
