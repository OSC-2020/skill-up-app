import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/global_keys.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_footer.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_header.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_quiz.dart';
import 'package:js_skill_up/screens/chapter/widgets/chapter_theory.dart';
import 'package:js_skill_up/services/redux/middleware/books/chapter/chapter_detail_db.middleware.dart';
import 'package:js_skill_up/services/redux/models/app_state.model.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_quiz.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/reducers/chapter_detail.reducer.dart';
import 'package:redux/redux.dart';

class ChapterDetailScreen extends StatelessWidget {
  final String chapterID;

  ChapterDetailScreen({this.chapterID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SafeArea(
        child: StoreConnector<AppState, ChapterDetailModel>(
          converter: (store) {
            ChapterDetailModel chapter = store.state.currentChapterDetail;
            if (chapter == null) {
              store.dispatch(loadChapterDetailFromDBMiddleware(
                  store.state.currentBook.id, this.chapterID));
            }
            return chapter;
          },
          builder: (BuildContext context, ChapterDetailModel detail) {
            if (detail == null) {
              return Center(
                child: Text(
                  'I am loading',
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            }

            final int activeIndex = (detail.activeIndex ?? 0);
            final double progressVal =
                (activeIndex + 1) / detail.contents.length;

            dynamic currentPage = detail.contents[activeIndex];
            final bool isQuiz = currentPage.pageType == ChapterPageType.QUIZ;
            bool isOptionSelected, showCorrectness;
            if (currentPage is ChapterQuizModel) {
              isOptionSelected =
                  currentPage.pageState != ChapterQuizPageState.INITIAL;
              showCorrectness = currentPage.pageState ==
                  ChapterQuizPageState.SHOW_CORRECTNESS;
            }
            final bool isFirstPage = (detail.activeIndex ?? 0) == 0;
            final bool isLastPage =
                (detail.activeIndex == detail.contents.length - 1);

            return Column(
              children: <Widget>[
                ChapterHeaderWidget(
                  progressValue: progressVal,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: isQuiz
                        ? ChapterQuizWidget(
                            quizPage: currentPage,
                          )
                        : ChapterTheoryWidget(
                            currentPage: currentPage,
                          ),
                  ),
                ),
                StoreConnector<AppState, Function>(
                    converter: (store) => callbackConverter(store, isQuiz,
                        isLastPage, showCorrectness, activeIndex),
                    builder:
                        (BuildContext context, Function nextClickCallback) {
                      return ChapterFooterWidget(
                        explanationString: currentPage.footerText,
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
      final handleNextClick = () {
        if (isLastPage) {
          store.dispatch(completeChapterMiddleware);
          GlobalKeys.navKey.currentState.pushNamed(AppRoutes.HOMEPAGE);
        } else {
          store.dispatch(ChapterDetailNextPageAction());
        }
      };

      if (isQuiz) {
        isCorrectnessShownToUser
            ? handleNextClick()
            : store.dispatch(ChapterDetailQuizShowCorrectnessAction());
      } else {
        handleNextClick();
      }
    };
  }
}
