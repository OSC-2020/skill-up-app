import 'package:js_skill_up/services/db/db_constants.dart';
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
        (data.containsKey(FirestoreBooksLevelCollections.CHAPTERS_ARRAY) &&
                (data[FirestoreBooksLevelCollections.CHAPTERS_ARRAY] is List))
            ? data[FirestoreBooksLevelCollections.CHAPTERS_ARRAY]
                .map<ChapterInfoModel>(
                    (chapter) => ChapterInfoModel.fromDynamicJson(chapter))
                .toList()
            : null;
    return BookDetailModel(
      id: data[FirestoreBooksLevelCollections.ID_STRING],
      title: data[FirestoreBooksLevelCollections.TITLE_STRING],
      totalChapters: data[FirestoreBooksLevelCollections.TOTAL_CHAPTERS_INT],
      chaptersCompleted:
          data[FirestoreBooksLevelCollections.CHAPTERS_COMPLETED_INT],
      chapters: chapters,
    );
  }
}
