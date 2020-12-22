import 'package:js_skill_up/services/db/db_constants.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';

class ChapterTheoryModel {
  final List<ContentDetailModel> content;
  final int pageType;
  final String footerText;

  ChapterTheoryModel({
    this.content,
    this.pageType = ChapterPageType.THEORY,
    this.footerText,
  });

  factory ChapterTheoryModel.fromMap(Map data) {
    List<ContentDetailModel> content = (data.containsKey(
                FirestoreChaptersContentLevelConstants.CONTENT_STRING) &&
            (data[FirestoreChaptersContentLevelConstants.CONTENT_STRING]
                is List))
        ? data[FirestoreChaptersContentLevelConstants.CONTENT_STRING]
            .map<ContentDetailModel>(
                (book) => ContentDetailModel.fromDynamicJson(book))
            .toList()
        : null;
    return ChapterTheoryModel(
      pageType: data[FirestoreChaptersContentLevelConstants.PAGE_TYPE_INT],
      content: content,
      footerText:
          data[FirestoreChaptersContentLevelConstants.FOOTER_HELP_TEXT_STRING],
    );
  }
}
