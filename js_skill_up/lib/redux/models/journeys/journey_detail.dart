import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';

class JourneyDetailModel {
  final String id;
  final String title;
  final int totalPaths;
  final int pathsCompleted;
  final double percentComplete;
  final List<PathDetailModel> paths;

  JourneyDetailModel({
    this.id,
    this.title,
    this.totalPaths,
    this.pathsCompleted,
    this.percentComplete,
    this.paths,
  });
}
