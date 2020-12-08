import 'package:flutter/material.dart';
import 'package:js_skill_up/services/redux/models/journeys/paths/base/path_content.dart';
import 'package:js_skill_up/widgets/path/path_content.dart';

class PathTheoryWidget extends StatelessWidget {
  final PathTheoryModel currentPage;

  PathTheoryWidget({this.currentPage});

  @override
  Widget build(BuildContext context) {
    return PathContentWidget(
      contents: currentPage.content,
    );
  }
}
