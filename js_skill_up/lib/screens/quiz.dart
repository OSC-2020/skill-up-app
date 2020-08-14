import 'package:flutter/material.dart';
import 'package:js_skill_up/widgets/quiz_ui/progress_indicator.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            QuizProgressIndicator(
              progressValue: 0.2,
            ),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
