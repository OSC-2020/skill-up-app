import 'package:js_skill_up/redux/models/journeys/paths/base/path_quiz.dart';
import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';

pathDetailReducer(PathDetailModel path, dynamic action) {
  if (action is PathDetailNextPageAction) {
    if (path.activeIndex == path.contents.length - 1) {
      return path;
    }
    return path.copyWith(activeIndex: (path.activeIndex ?? 0) + 1);
  }

  if (action is PathDetailPreviousPageAction) {
    if (path.activeIndex == 0) {
      return path;
    }
    return path.copyWith(activeIndex: path.activeIndex - 1);
  }

  if (action is PathDetailCompletePathAction) {
    print('Completing the course');
    return path.copyWith(isCompleted: true);
  }

  if (action is PathDetailStartPathAction) {
    print('Starting the course');
    return path.copyWith(isCompleted: false, activeIndex: 0);
  }

  if (action is PathDetailQuizSelectOptionAction) {
    return path.copyCurrentQuizPage(
        currentPageIndex: path.activeIndex,
        optionIndex: action.optionIndex,
        newQuizPageState: PathQuizPageState.SELECTION_DONE);
  }

  if (action is PathDetailQuizShowCorrectnessAction) {
    return path.copyCurrentQuizPage(
        currentPageIndex: path.activeIndex,
        newQuizPageState: PathQuizPageState.SHOW_CORRECTNESS);
  }

  return path;
}

class PathDetailStartPathAction {}

class PathDetailNextPageAction {}

class PathDetailPreviousPageAction {}

class PathDetailCompletePathAction {}

// region QuizOption
class PathDetailQuizSelectOptionAction {
  final int optionIndex;

  PathDetailQuizSelectOptionAction({
    this.optionIndex,
  });
}

class PathDetailQuizShowCorrectnessAction {}

// endregion QuizOption
