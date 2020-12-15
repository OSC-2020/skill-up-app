class ContentDetailModel {
  final String content;
  final int contentType;

  ContentDetailModel({
    this.content,
    this.contentType,
  });
}

class ChapterPageType {
  static const THEORY = 1;
  static const QUIZ = 2;
}
