import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';

pathDetailReducer(PathDetailModel path, dynamic action) {
  if (action is PathDetailNextPageAction) {
    if (action.pathDetail.activeIndex ==
        action.pathDetail.contents.length - 1) {
      return action.pathDetail;
    }
    return PathDetailModel(
      id: action.pathDetail.id,
      title: action.pathDetail.title,
      containsContent: action.pathDetail.containsContent,
      lastContentPagePos: action.pathDetail.lastContentPagePos,
      isCompleted: action.pathDetail.isCompleted,
      contents: action.pathDetail.contents,
      activeIndex: (action.pathDetail.activeIndex ?? 0) + 1,
    );
  }
  if (action is PathDetailPreviousPageAction) {
    if (action.pathDetail.activeIndex == 0) {
      return action.pathDetail;
    }
    return PathDetailModel(
      id: action.pathDetail.id,
      title: action.pathDetail.title,
      containsContent: action.pathDetail.containsContent,
      lastContentPagePos: action.pathDetail.lastContentPagePos,
      isCompleted: action.pathDetail.isCompleted,
      contents: action.pathDetail.contents,
      activeIndex: action.pathDetail.activeIndex - 1,
    );
  }
  if (action is PathDetailCompletePathAction) {
    print('Completing the course');
    return PathDetailModel(
      id: action.pathDetail.id,
      title: action.pathDetail.title,
      containsContent: action.pathDetail.containsContent,
      lastContentPagePos: action.pathDetail.lastContentPagePos,
      isCompleted: true,
      contents: action.pathDetail.contents,
      activeIndex: action.pathDetail.activeIndex,
    );
  }

  return path;
}

class PathDetailNextPageAction {
  final PathDetailModel _pathDetail;

  PathDetailNextPageAction(this._pathDetail);

  PathDetailModel get pathDetail => this._pathDetail;
}

class PathDetailPreviousPageAction {
  final PathDetailModel _pathDetail;

  PathDetailPreviousPageAction(this._pathDetail);

  PathDetailModel get pathDetail => this._pathDetail;
}

class PathDetailCompletePathAction {
  final PathDetailModel _pathDetail;

  PathDetailCompletePathAction(this._pathDetail);

  PathDetailModel get pathDetail => this._pathDetail;
}
