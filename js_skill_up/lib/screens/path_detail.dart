import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';
import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';
import 'package:js_skill_up/widgets/path/path_footer.dart';
import 'package:js_skill_up/widgets/path/path_header.dart';
import 'package:js_skill_up/widgets/path/path_quiz.dart';
import 'package:js_skill_up/widgets/path/path_theory.dart';

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

            return Column(
              children: <Widget>[
                PathHeaderWidget(
                  progressValue: progressVal,
                ),
                Expanded(
                  child: isQuiz
                      ? PathQuizWidget(
                          quizPage: currentPage,
                        )
                      : PathTheoryWidget(
                          currentPage: currentPage,
                        ),
                ),
                PathFooterWidget(
                  explanationString: currentPage.footerHelpText,
                  isQuiz: false,
                  hidePrev: (detail.activeIndex ?? 0) == 0 ||
                      (detail.activeIndex >= detail.lastContentPagePos),
                  isLastPage:
                  (detail.activeIndex == detail.contents.length - 1),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
