import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_content.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_quiz.dart';
import 'package:js_skill_up/services/redux/reducers/books_detail_reducer.dart';

class ChapterQuizWidget extends StatelessWidget {
  final ChapterQuizModel quizPage;

  ChapterQuizWidget({
    @required this.quizPage,
  });

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
    return ChapterContentWidget(
      contents: quizPage.content,
    );
  }

  _getOptions() {
    final List<Widget> widgets = List<Widget>();
    for (int idx = 0; idx < quizPage.options.length; idx++) {
      widgets.add(ChapterQuizOptionWidget(
        optionText: quizPage.options[idx].content,
        optionIndex: idx,
        isSelected: idx == quizPage.userSelectionOptionIndex,
        showCorrectness:
            quizPage.pageState == ChapterQuizPageState.SHOW_CORRECTNESS,
        isCorrect:
            quizPage.userSelectionOptionIndex == quizPage.correctOptionIndex,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgets,
    );
  }
}

class ChapterQuizOptionWidget extends StatelessWidget {
  final String optionText;
  final int optionIndex;
  final bool isSelected;
  final bool isCorrect;
  final bool showCorrectness;

  ChapterQuizOptionWidget(
      {@required this.optionText,
      @required this.optionIndex,
      this.isCorrect,
      this.isSelected = false,
      this.showCorrectness = false});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Function>(
      converter: (store) => () => store.dispatch(
          ChapterDetailQuizSelectOptionAction(optionIndex: optionIndex)),
      builder: (BuildContext context, Function selectOptionCallback) {
        return GestureDetector(
          onTap: () {
            selectOptionCallback();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: isSelected
                    ? Border(
                        left: BorderSide(
                            width: 4.0, color: Theme.of(context).primaryColor))
                    : Border.all(color: Color(0xFFdee1ec)),
              ),
              child: Row(
                mainAxisAlignment: isSelected && showCorrectness
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: <Widget>[
                  Text(optionText),
                  isSelected && showCorrectness
                      ? _getCorrectnessWidget(isCorrect)
                      : Text("")
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getCorrectnessWidget(bool isCorrect) {
    if (isCorrect) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    }
    return Icon(
      Icons.cancel,
      color: Colors.red,
    );
  }
}
