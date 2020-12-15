import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';

class ChapterTheoryModel {
  final List<ContentDetailModel> content;
  final int pageType;
  final String footerHelpText;

  ChapterTheoryModel({
    this.content,
    this.pageType = ChapterPageType.THEORY,
    this.footerHelpText,
  });
}
