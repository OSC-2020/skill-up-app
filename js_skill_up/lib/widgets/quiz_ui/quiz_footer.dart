import 'package:flutter/material.dart';

class QuizFooter extends StatelessWidget {
  final String explanationString;

  QuizFooter({this.explanationString = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: this.explanationString.length > 0
                  ? Text(this.explanationString)
                  : Container()),
          FloatingActionButton(
            child: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
