import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_quiz.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';

ChapterDetailModel chapterDetailReducer(
    ChapterDetailModel chapter, dynamic action) {
  if (action is ChapterDetailSaveToStoreAction) {
    return action.chapter;
  }

  if (action is ChapterDetailNextPageAction) {
    if (chapter.activeIndex == chapter.contents.length - 1) {
      return chapter;
    }
    return chapter.copyWith(activeIndex: (chapter.activeIndex ?? 0) + 1);
  }

  if (action is ChapterDetailPreviousPageAction) {
    if (chapter.activeIndex == 0) {
      return chapter;
    }
    return chapter.copyWith(activeIndex: chapter.activeIndex - 1);
  }

  if (action is ChapterDetailCompleteChapterAction) {
    return chapter.copyWith(isCompleted: true);
  }

  if (action is ChapterDetailStartChapterAction) {
    return chapter.copyWith(isCompleted: false, activeIndex: 0);
  }

  if (action is ChapterDetailQuizSelectOptionAction) {
    return chapter.copyCurrentQuizPage(
        currentPageIndex: chapter.activeIndex,
        optionIndex: action.optionIndex,
        newQuizPageState: ChapterQuizPageState.SELECTION_DONE);
  }

  if (action is ChapterDetailQuizShowCorrectnessAction) {
    return chapter.copyCurrentQuizPage(
        currentPageIndex: chapter.activeIndex,
        newQuizPageState: ChapterQuizPageState.SHOW_CORRECTNESS);
  }

  return chapter;
}

class ChapterDetailStartChapterAction {}

class ChapterDetailSaveToStoreAction {
  final ChapterDetailModel chapter;

  ChapterDetailSaveToStoreAction({this.chapter});
}

class ChapterDetailNextPageAction {}

class ChapterDetailPreviousPageAction {}

class ChapterDetailCompleteChapterAction {}

// region QuizOption
class ChapterDetailQuizSelectOptionAction {
  final int optionIndex;

  ChapterDetailQuizSelectOptionAction({
    this.optionIndex,
  });
}

class ChapterDetailQuizShowCorrectnessAction {}

// endregion QuizOption
