import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_content.dart';

enum PathQuizPageState {
  INITIAL,
  SELECTION_DONE,
  SHOW_CORRECTNESS,
  SUBMITTED,
}

class PathQuizModel extends PathTheoryModel {
  final int numberOptions;
  final List<ContentDetailModel> options;
  final int correctOptionIndex;
  final bool isCorrect;
  final PathQuizPageState pageState;
  final int userSelectionOptionIndex;

  PathQuizModel({
    this.numberOptions,
    this.options,
    this.correctOptionIndex,
    this.isCorrect,
    this.pageState = PathQuizPageState.INITIAL,
    this.userSelectionOptionIndex,
    List<ContentDetailModel> content,
    String footerHelpText,
  }) : super(
          content: content,
          pageType: PathPageType.QUIZ,
          footerHelpText: footerHelpText,
        );

  PathQuizModel copyWith({
    bool isCorrect,
    int selectedOptionIndex,
    PathQuizPageState newQuizPageState,
  }) {
    return PathQuizModel(
      numberOptions: this.numberOptions,
      options: this.options,
      correctOptionIndex: this.correctOptionIndex,
      content: this.content,
      footerHelpText: this.footerHelpText,
      isCorrect: isCorrect ?? this.isCorrect,
      userSelectionOptionIndex:
          selectedOptionIndex ?? this.userSelectionOptionIndex,
      pageState: newQuizPageState ?? this.pageState,
    );
  }
}
