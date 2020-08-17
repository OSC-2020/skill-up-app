import 'package:js_skill_up/redux/models/journeys/paths/base/path_content.dart';

import 'base/path_quiz.dart';

class PathDetailModel {
  final String id;
  final String title;
  final bool containsContent;
  final bool isContentDone;
  final bool isQuizDone;
  final List<PathQuizModel> quiz;
  final List<PathContentModel> content;
  final int activeIndex;

  PathDetailModel({
    this.id,
    this.title,
    this.containsContent = true,
    this.isContentDone,
    this.isQuizDone,
    this.quiz,
    this.content,
    this.activeIndex,
  });
}
