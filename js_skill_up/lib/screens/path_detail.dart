import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';
import 'package:js_skill_up/widgets/path/path_content.dart';
import 'package:js_skill_up/widgets/path/path_footer.dart';
import 'package:js_skill_up/widgets/path/path_header.dart';

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
                (activeIndex + 1) / detail.content.length;
            return Column(
              children: <Widget>[
                PathHeaderWidget(
                  progressValue: progressVal,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      PathContentWidget(
                        question:
                            detail.content[activeIndex].content[0].content,
                      ),
//                      QuizOption(
//                        option: 'True',
//                      ),
//                      QuizOption(
//                        option: 'False',
//                      )
                    ],
                  ),
                ),
                PathFooterWidget(
                    explanationString:
                        detail.content[activeIndex].footerHelpText),
              ],
            );
          },
        ),
      ),
    );
  }
}
