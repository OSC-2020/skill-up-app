import 'package:cloud_firestore/cloud_firestore.dart';

import 'base/chapter_base.dart';
import 'base/chapter_content.dart';
import 'base/chapter_quiz.dart';

class ChapterInfoModel {
  final String id;
  final String title;
  final bool isCompleted;
  Timestamp completedOn;

  ChapterInfoModel({this.id, this.title, this.isCompleted, this.completedOn}) {
    if (this.completedOn == null) {
      this.completedOn = Timestamp.now();
    }
  }

  factory ChapterInfoModel.fromDynamicJson(data) {
    return ChapterInfoModel(
      id: data['id'],
      title: data['title'],
      isCompleted: data['isCompleted'],
      completedOn: data['completedOn'],
    );
  }
}

class ChapterDetailModel extends ChapterInfoModel {
  final bool containsContent;
  final List<ChapterTheoryModel> contents;
  int lastContentPagePos;
  final int activeIndex;

  ChapterDetailModel({
    id,
    title,
    isCompleted,
    completedOn,
    this.containsContent = true,
    this.lastContentPagePos,
    this.contents,
    this.activeIndex,
  }) : super(
            id: id,
            title: title,
            isCompleted: isCompleted,
            completedOn: completedOn) {
    if (this.lastContentPagePos == null && this.contents != null) {
      this.lastContentPagePos = contents.length;
    }
  }

  factory ChapterDetailModel.fromMap(Map data) {
    List<ChapterTheoryModel> chapters = (data.containsKey('chapters') &&
            (data['chapters'] is List))
        ? data['chapters']
            .map<ChapterTheoryModel>((book) => ChapterTheoryModel.fromMap(book))
            .toList()
        : null;
    return ChapterDetailModel(
      id: data['id'],
      title: data['title'],
      isCompleted: data['isCompleted'],
      completedOn: data['completedOn'],
      containsContent: data['containsContent'],
      lastContentPagePos: data['lastContentPagePos'],
      activeIndex: data['activeIndex'],
      contents: chapters,
    );
  }

  ChapterDetailModel copyWith({
    bool isCompleted,
    int activeIndex,
    List<ChapterTheoryModel> contents,
  }) {
    return ChapterDetailModel(
      id: this.id,
      title: this.title,
      containsContent: this.containsContent,
      lastContentPagePos: this.lastContentPagePos,
      contents: contents ?? this.contents,
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
