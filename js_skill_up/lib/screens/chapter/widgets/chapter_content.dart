import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';

class AllowedWidgets {
  static const int SIMPLE_TEXT = 1;
  static const int CODE_BLOCK = 2;
}

class ChapterContentWidget extends StatelessWidget {
  final List<ContentDetailModel> contents;

  ChapterContentWidget({this.contents});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildContents(context, contents),
      ),
    );
  }

  _buildContents(BuildContext context, List<ContentDetailModel> contents) {
    List<Widget> widgets = List<Widget>();
    for (int i = 0; i < contents.length; i++) {
      switch (contents[i].contentType) {
        case AllowedWidgets.CODE_BLOCK:
          widgets.add(
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                contents[i].content ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          break;
        case AllowedWidgets.SIMPLE_TEXT:
        default:
          widgets.add(Text(contents[i].content) ?? "");
          break;
      }
      widgets.add(
        SizedBox(height: 20),
      );
    }
    return widgets;
  }
}
