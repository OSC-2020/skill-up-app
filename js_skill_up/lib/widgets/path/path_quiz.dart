import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_quiz.dart';
import 'package:js_skill_up/widgets/path/path_content.dart';

class PathQuizWidget extends StatelessWidget {
  final PathQuizModel quizPage;

  PathQuizWidget({this.quizPage});

  @override
  Widget build(BuildContext context) {
    final bool hasOptions =
        quizPage.options != null && quizPage.options.length > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _getBody(),
        hasOptions ? _getOptions() : Text(""),
      ],
    );
  }

  _getBody() {
    return PathContentWidget(
      contents: quizPage.content,
    );
  }

  _getOptions() {
    final List<Widget> widgets = List<Widget>();
    for (int i = 0; i < quizPage.options.length; i++) {
      widgets.add(PathQuizOptionWidget(
        option: quizPage.options[i].content,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}

class PathQuizOptionWidget extends StatefulWidget {
  final String option;

  PathQuizOptionWidget({this.option});

  @override
  _QuizOption createState() => _QuizOption();
}

class _QuizOption extends State<PathQuizOptionWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this._selected = true;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: _selected
                ? Border(
                    left: BorderSide(
                        width: 4.0, color: Theme.of(context).primaryColor))
                : Border.all(color: Color(0xFFdee1ec)),
          ),
          child: Row(
            children: <Widget>[
              Text(widget.option),
            ],
          ),
        ),
      ),
    );
  }
}
