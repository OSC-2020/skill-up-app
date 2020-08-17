import 'package:flutter/material.dart';

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
