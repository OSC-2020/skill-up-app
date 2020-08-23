import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_quiz.dart';
import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';
import 'package:js_skill_up/redux/reducers/path_detail_reducer.dart';
import 'package:js_skill_up/widgets/path/path_footer.dart';
import 'package:js_skill_up/widgets/path/path_header.dart';
import 'package:js_skill_up/widgets/path/path_quiz.dart';
import 'package:js_skill_up/widgets/path/path_theory.dart';
import 'package:redux/redux.dart';

class PathDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: StoreConnector<AppState, PathDetailModel>(
          converter: (store) => store.state.currentPath,
          builder: (BuildContext context, PathDetailModel detail) {
            final int activeIndex = (detail.activeIndex ?? 0);
            final double progressVal =
                (activeIndex + 1) / detail.contents.length;

            dynamic currentPage = detail.contents[activeIndex];
            final bool isQuiz = currentPage.pageType == PathPageType.QUIZ;
            bool isOptionSelected, showCorrectness;
            if (currentPage is PathQuizModel) {
              isOptionSelected =
                  currentPage.pageState != PathQuizPageState.INITIAL;
              showCorrectness =
                  currentPage.pageState == PathQuizPageState.SHOW_CORRECTNESS;
            }
            final bool isFirstPage = (detail.activeIndex ?? 0) == 0;
            final bool isLastPage =
                (detail.activeIndex == detail.contents.length - 1);

            return Column(
              children: <Widget>[
                PathHeaderWidget(
                  progressValue: progressVal,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: isQuiz
                        ? PathQuizWidget(
                            quizPage: currentPage,
                          )
                        : PathTheoryWidget(
                            currentPage: currentPage,
                          ),
                  ),
                ),
                StoreConnector<AppState, Function>(
                    converter: (store) => callbackConverter(store, isQuiz,
                        isLastPage, showCorrectness, activeIndex),
                    builder:
                        (BuildContext context, Function nextClickCallback) {
                      return PathFooterWidget(
                        explanationString: currentPage.footerHelpText,
                        hidePrev: isFirstPage || isQuiz,
                        isLastPage: isLastPage,
                        onNextClick: nextClickCallback,
                        isNextDisabled: isQuiz && !isOptionSelected,
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }

  Function callbackConverter(Store<AppState> store, bool isQuiz,
      bool isLastPage, bool isCorrectnessShownToUser, int currentPageIndex) {
    return () {
      if (isQuiz) {
        if (isCorrectnessShownToUser) {
          if (isLastPage) {
            store.dispatch(PathDetailCompletePathAction());
          } else {
            store.dispatch(PathDetailNextPageAction());
          }
        } else {
          store.dispatch(PathDetailQuizShowCorrectnessAction());
        }
      } else {
        if (isLastPage) {
          store.dispatch(PathDetailNextPageAction());
        } else {
          store.dispatch(PathDetailNextPageAction());
        }
      }
    };
  }
}
