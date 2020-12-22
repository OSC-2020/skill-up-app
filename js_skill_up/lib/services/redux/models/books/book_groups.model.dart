import 'package:flutter/foundation.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/services/db/db_constants.dart';

class BookInfoModel implements UIWidgetTypeModel {
  int uiType;
  final String id;
  final String title;
  final String iconUrl;
  final double progress;

  BookInfoModel({
    @required this.id,
    @required this.title,
    @required this.uiType,
    this.iconUrl,
    this.progress,
  });

  factory BookInfoModel.fromDynamicJson(dynamic data) {
    return BookInfoModel(
      uiType: data['uiType'],
      id: data['id'],
      title: data['title'],
      iconUrl: data['iconUrl'],
      progress: data['progress'],
    );
  }
}

class BookGroupsModel implements UIWidgetTypeModel {
  final String title;
  final int uiType;
  final List<BookInfoModel> books;

  BookGroupsModel({
    this.title,
    this.books,
    this.uiType,
  });

  factory BookGroupsModel.fromMap(Map data) {
    List<BookInfoModel> books = (data
                .containsKey(FirestoreBookGroupsLevelCollections.BOOKS_ARRAY) &&
            (data[FirestoreBookGroupsLevelCollections.BOOKS_ARRAY] is List))
        ? data[FirestoreBookGroupsLevelCollections.BOOKS_ARRAY]
            .map<BookInfoModel>((book) => BookInfoModel.fromDynamicJson(book))
            .toList()
        : null;
    return BookGroupsModel(
      title: data[FirestoreBookGroupsLevelCollections.TITLE_STRING],
      books: books,
      uiType: data[FirestoreBookGroupsLevelCollections.UI_TYPE_INT],
    );
  }
}
