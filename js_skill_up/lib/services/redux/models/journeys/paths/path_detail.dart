import 'base/path_base.dart';
import 'base/path_content.dart';
import 'base/path_quiz.dart';

class PathDetailModel {
  final String id;
  final String title;
  final bool containsContent;
  final bool isCompleted;
  final List<PathTheoryModel> contents;
  int lastContentPagePos;
  final int activeIndex;

  PathDetailModel({
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

  PathDetailModel copyWith({
    bool isCompleted,
    int activeIndex,
  }) {
    return PathDetailModel(
      id: this.id,
      title: this.title,
      containsContent: this.containsContent,
      lastContentPagePos: this.lastContentPagePos,
      contents: this.contents,
      isCompleted: isCompleted ?? this.isCompleted,
      activeIndex: activeIndex ?? this.activeIndex,
    );
  }

  PathDetailModel copyCurrentQuizPage(
      {int currentPageIndex,
      int optionIndex,
      PathQuizPageState newQuizPageState}) {
    if (newQuizPageState != null) {
      print('ChangingState to $newQuizPageState');
    }
    int index = 0;
    List<PathTheoryModel> newContents = this.contents.map((page) {
      if (page.pageType == PathPageType.QUIZ && index == currentPageIndex) {
        index++;
        PathQuizModel newPage = page;
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

    return PathDetailModel(
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
