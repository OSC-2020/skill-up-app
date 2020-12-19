class ChapterPageType {
  static const THEORY = 1;
  static const QUIZ = 2;
}

class ContentType {
  static const int NORMAL_STRING = 1;
  static const int CODE = 2;
  static const int QUOTATION = 3;
}

class ContentDetailModel {
  final String content;
  final int contentType;

  ContentDetailModel({
    this.content,
    this.contentType = ContentType.NORMAL_STRING,
  });

  factory ContentDetailModel.fromDynamicJson(data) {
    return ContentDetailModel(
      content: data['content'],
      contentType: data['contentType'],
    );
  }
}
