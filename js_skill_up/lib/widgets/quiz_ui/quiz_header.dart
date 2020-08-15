import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final double progressValue;

  QuizHeader({this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {},
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
