import 'package:flutter/material.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_content.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_content.dart';

class ChapterTheoryWidget extends StatelessWidget {
  final ChapterTheoryModel currentPage;

  ChapterTheoryWidget({this.currentPage});

  @override
  Widget build(BuildContext context) {
    return ChapterContentWidget(
      contents: currentPage.content,
    );
  }
}
