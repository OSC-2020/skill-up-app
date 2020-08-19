import 'package:js_skill_up/redux/models/journeys/paths/base/path_content.dart';

class PathDetailModel {
  final String id;
  final String title;
  final bool containsContent;
  final bool isCompleted;
  final List<PathTheoryModel> contents;
  int lastContentPagePos;
  final int activeIndex;

  PathDetailModel({
    this.id,
    this.title,
    this.containsContent = true,
    this.lastContentPagePos,
    this.isCompleted,
    this.contents,
    this.activeIndex,
  }) {
    if (this.lastContentPagePos == null) {
      this.lastContentPagePos = contents.length;
    }
  }
}
