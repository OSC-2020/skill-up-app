import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_content.dart';

class PathQuizModel extends PathTheoryModel {
  final int numberOptions;
  final List<ContentDetailModel> options;
  final int correctResponse;

  PathQuizModel({
    this.numberOptions,
    this.options,
    this.correctResponse,
    List<ContentDetailModel> content,
    String footerHelpText,
  }) : super(
          content: content,
          pageType: PathPageType.QUIZ,
          footerHelpText: footerHelpText,
        );
}
