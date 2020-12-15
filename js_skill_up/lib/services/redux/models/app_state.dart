import 'package:flutter/foundation.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_base.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_content.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/base/chapter_quiz.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';

@immutable
class AppState {
  final UserModel user;
  final ChapterDetailModel currentChapter;

  AppState({@required this.user, this.currentChapter});

  factory AppState.initial() {
    return AppState(
      user: null,
      currentChapter: ChapterDetailModel(
          containsContent: true,
          id: "1",
          title: 'Introduction',
          lastContentPagePos: 5,
          contents: [
            ChapterTheoryModel(content: [
              ContentDetailModel(content: 'Hi I am First', contentType: 1)
            ], footerHelpText: 'yay this works 1'),
            ChapterTheoryModel(content: [
              ContentDetailModel(
                  content: 'Lets get started with variables', contentType: 1),
              ContentDetailModel(content: 'var x = 2;', contentType: 2),
              ContentDetailModel(
                  content: 'Variables can be declared using const, let or var',
                  contentType: 1),
              ContentDetailModel(
                  content: 'const a = 12;\n let d = 12', contentType: 2),
              ContentDetailModel(
                  content:
                      'const, let create block scoped variables.\n While var creates function scoped variables.',
                  contentType: 1),
            ], footerHelpText: 'yay this works 2'),
            ChapterTheoryModel(content: [
              ContentDetailModel(content: 'Hi I am Third', contentType: 1)
            ], footerHelpText: 'yay this works 3'),
            ChapterTheoryModel(content: [
              ContentDetailModel(content: 'Hi I am Fourth', contentType: 1)
            ], footerHelpText: 'yay this works 4'),
            ChapterTheoryModel(content: [
              ContentDetailModel(content: 'Hi I am Second', contentType: 1)
            ], footerHelpText: 'yay this works 2'),
            ChapterQuizModel(
                content: [
                  ContentDetailModel(content: 'Hi I am First', contentType: 1)
                ],
                footerHelpText: 'yay this works 1',
                correctOptionIndex: 0,
                options: [
                  ContentDetailModel(content: 'true', contentType: 1),
                  ContentDetailModel(content: 'false', contentType: 1),
                ]),
            ChapterQuizModel(
                content: [
                  ContentDetailModel(
                      content: 'Lets get started with variables',
                      contentType: 1),
                  ContentDetailModel(content: 'var x = 2;', contentType: 2),
                  ContentDetailModel(
                      content:
                          'Variables can be declared using const, let or var',
                      contentType: 1),
                  ContentDetailModel(
                      content: 'const a = 12;\n let d = 12', contentType: 2),
                  ContentDetailModel(
                      content:
                          'const, let create block scoped variables.\n While var creates function scoped variables.',
                      contentType: 1),
                ],
                footerHelpText: 'yay this works 2',
                correctOptionIndex: 2,
                options: [
                  ContentDetailModel(content: '1', contentType: 1),
                  ContentDetailModel(content: '2', contentType: 1),
                  ContentDetailModel(content: '3', contentType: 1),
                  ContentDetailModel(content: '4', contentType: 1),
                ]),
            ChapterQuizModel(content: [
              ContentDetailModel(content: 'Hi I am Fourth', contentType: 1)
            ], footerHelpText: 'yay this works 4'),
            ChapterQuizModel(content: [
              ContentDetailModel(content: 'Hi I am Second', contentType: 1)
            ], footerHelpText: 'yay this works 2'),
          ]),
    );
  }
}
