import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';

class PathContentModel {
  final List<ContentDetailModel> content;

  final String footerHelpText;

  PathContentModel({
    this.content,
    this.footerHelpText,
  });
}
