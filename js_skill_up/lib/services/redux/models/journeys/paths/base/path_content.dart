import 'package:js_skill_up/services/redux/models/journeys/paths/base/path_base.dart';

class PathTheoryModel {
  final List<ContentDetailModel> content;
  final int pageType;
  final String footerHelpText;

  PathTheoryModel({
    this.content,
    this.pageType = PathPageType.THEORY,
    this.footerHelpText,
  });
}
