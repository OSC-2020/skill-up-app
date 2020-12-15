import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_content.dart';

enum ChapterQuizPageState {
  INITIAL,
  SELECTION_DONE,
  SHOW_CORRECTNESS,
  SUBMITTED,
}

class ChapterQuizModel extends ChapterTheoryModel {
  final int numberOptions;
  final List<ContentDetailModel> options;
  final int correctOptionIndex;
  final bool isCorrect;
  final ChapterQuizPageState pageState;
  final int userSelectionOptionIndex;

  ChapterQuizModel({
    this.numberOptions,
    this.options,
    this.correctOptionIndex,
    this.isCorrect,
    this.pageState = ChapterQuizPageState.INITIAL,
    this.userSelectionOptionIndex,
    List<ContentDetailModel> content,
    String footerHelpText,
  }) : super(
          content: content,
          pageType: ChapterPageType.QUIZ,
          footerHelpText: footerHelpText,
        );

  ChapterQuizModel copyWith({
    bool isCorrect,
    int selectedOptionIndex,
    ChapterQuizPageState newQuizPageState,
  }) {
    return ChapterQuizModel(
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
