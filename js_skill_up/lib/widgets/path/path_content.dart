import 'package:flutter/material.dart';

class PathContentWidget extends StatelessWidget {
  final String question;

  PathContentWidget({this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Text(this.question),
        ],
      ),
    );
  }
}
