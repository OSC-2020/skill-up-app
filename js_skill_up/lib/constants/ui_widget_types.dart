import 'package:flutter/foundation.dart';

class UIWidgetTypes {
  static final int BOOK_INFO_TILE = 1;
}

abstract class UIWidgetTypeModel {
  int type;
}

class BookInfoModel {
  final String title;
  final String iconUrl;
  final double progress;

  BookInfoModel({@required this.title, this.iconUrl, this.progress});
}

class BookInfoTileModel extends UIWidgetTypeModel {
  final int type;
  final BookInfoModel data;

  BookInfoTileModel({@required this.type, this.data});
}
