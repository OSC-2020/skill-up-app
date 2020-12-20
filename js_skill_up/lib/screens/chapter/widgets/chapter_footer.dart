import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/services/redux/models/app_state.model.dart';
import 'package:js_skill_up/services/redux/reducers/chapter_detail.reducer.dart';
import 'package:redux/redux.dart';

class ChapterFooterWidget extends StatelessWidget {
  static const String PAGE_TYPE_CONTENT = 'content';
  static const String PAGE_TYPE_QUIZ_CORRECT = 'correct';
  static const String PAGE_TYPE_Quiz_WRONG = 'wrong';

  final String explanationString;
  final bool isLastPage;
  final bool hidePrev;
  final bool isNextDisabled;
  final void Function() onNextClick;

  ChapterFooterWidget({
    this.explanationString = "",
    this.hidePrev,
    @required this.isLastPage,
    @required this.isNextDisabled,
    this.onNextClick,
  });

  @override
  Widget build(BuildContext context) {
    String pageType = PAGE_TYPE_CONTENT;
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
                  hidePrev
                      ? Text("")
                      : IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            store.dispatch(ChapterDetailPreviousPageAction());
                          },
                        ),
                  Expanded(
                      child: (this.explanationString ?? "").length > 0
                          ? Text(this.explanationString)
                          : Container()),
                  FloatingActionButton.extended(
                    backgroundColor: _getNextButtonBackgroundColor(
                      context,
                      isNextDisabled,
                      isLastPage,
                    ),
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ),
                    label: isLastPage ? Text("Done") : Text("Next"),
                    onPressed: isNextDisabled
                        ? null
                        : () {
                            if (this.onNextClick != null) {
                              this.onNextClick();
                            } else {
                              throw UnimplementedError();
                            }
                          },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _getNextButtonBackgroundColor(
      BuildContext context, bool btnDisabled, bool isLast) {
    if (btnDisabled) {
      return Colors.grey;
    }
    return isLast ? Colors.lightGreen : Theme.of(context).accentColor;
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
