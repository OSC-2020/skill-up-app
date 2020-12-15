import 'base/chapter_base.dart';
import 'base/chapter_content.dart';
import 'base/chapter_quiz.dart';

class ChapterDetailModel {
  final String id;
  final String title;
  final bool containsContent;
  final bool isCompleted;
  final List<ChapterTheoryModel> contents;
  int lastContentPagePos;
  final int activeIndex;

  ChapterDetailModel({
    this.id,
    this.title,
    this.containsContent = true,
    this.lastContentPagePos,
    this.isCompleted,
    this.contents,
    this.activeIndex,
  }) {
    if (this.lastContentPagePos == null && this.contents != null) {
      this.lastContentPagePos = contents.length;
    }
  }

  ChapterDetailModel copyWith({
    bool isCompleted,
    int activeIndex,
  }) {
    return ChapterDetailModel(
      id: this.id,
      title: this.title,
      containsContent: this.containsContent,
      lastContentPagePos: this.lastContentPagePos,
      contents: this.contents,
      isCompleted: isCompleted ?? this.isCompleted,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }

  ChapterDetailModel copyCurrentQuizPage(
      {int currentPageIndex,
      int optionIndex,
      ChapterQuizPageState newQuizPageState}) {
    if (newQuizPageState != null) {
      print('ChangingState to $newQuizPageState');
    }
    int index = 0;
    List<ChapterTheoryModel> newContents = this.contents.map((page) {
      if (page.pageType == ChapterPageType.QUIZ && index == currentPageIndex) {
        index++;
        ChapterQuizModel newPage = page;
        newPage = newPage.copyWith(
            isCorrect:
                newPage.correctOptionIndex == newPage.userSelectionOptionIndex,
            selectedOptionIndex: optionIndex,
            newQuizPageState: newQuizPageState);
        return newPage;
      }

      index++;
      return page;
    }).toList();

    return ChapterDetailModel(
      id: this.id,
      title: this.title,
      containsContent: this.containsContent,
      lastContentPagePos: this.lastContentPagePos,
      contents: newContents,
      isCompleted: isCompleted ?? this.isCompleted,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }
}
