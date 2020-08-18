import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/path_detail_reducer.dart';
import 'package:redux/redux.dart';

class PathFooterWidget extends StatelessWidget {
  final String explanationString;
  final bool isQuiz;
  final bool isLastStep;
  final bool isFirstStep;
  static const String PAGE_TYPE_CONTENT = 'content';
  static const String PAGE_TYPE_QUIZ_CORRECT = 'correct';
  static const String PAGE_TYPE_Quiz_WRONG = 'wrong';

  PathFooterWidget({
    this.explanationString = "",
    this.isQuiz = false,
    this.isFirstStep,
    this.isLastStep,
  });

  @override
  Widget build(BuildContext context) {
    String pageType = PAGE_TYPE_CONTENT;
    if (isQuiz) {}
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: getTopBorderColor(context, pageType),
                ),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: StoreConnector<AppState, Store<AppState>>(
                converter: (store) => store,
                builder: (BuildContext context, Store<AppState> store) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      isFirstStep
                          ? Text("")
                          : IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                store.dispatch(
                                  PathDetailPreviousPageAction(
                                      store.state.currentPath),
                                );
                              },
                            ),
                      Expanded(
                          child: this.explanationString.length > 0
                              ? Text(this.explanationString)
                              : Container()),
                      isLastStep
                          ? Text("")
                          : FloatingActionButton.extended(
                              icon: Icon(Icons.arrow_forward_ios),
                              label: Text("Next"),
                              onPressed: () {
                                store.dispatch(
                                  PathDetailNextPageAction(
                                      store.state.currentPath),
                                );
                              },
                            )
                    ],
                  );
                })),
      ],
    );
  }

  getTopBorderColor(BuildContext context, String pageType) {
    switch (pageType) {
      case PAGE_TYPE_CONTENT:
        return Theme.of(context).primaryColor;
      case PAGE_TYPE_QUIZ_CORRECT:
        return Theme.of(context).primaryColorDark;
      case PAGE_TYPE_Quiz_WRONG:
        return Theme.of(context).accentColor;
    }
  }
}
