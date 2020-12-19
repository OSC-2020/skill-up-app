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
    List<ContentDetailModel> content =
        (data.containsKey('content') && (data['content'] is List))
            ? data['content']
                .map<ContentDetailModel>(
                    (book) => ContentDetailModel.fromDynamicJson(book))
                .toList()
            : null;
    return ChapterTheoryModel(
      pageType: data['pageType'],
      content: content,
      footerText: data['footerHelpText'],
    );
  }
}
