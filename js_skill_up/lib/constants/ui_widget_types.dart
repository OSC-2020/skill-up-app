import 'package:flutter/foundation.dart';

class UIWidgetTypes {
  static final int JOURNEY_INFO_TILE = 1;
}

abstract class UIWidgetTypeModel {
  int type;
}

class JourneyInfoModel {
  final String title;
  final String iconUrl;
  final double progress;

  JourneyInfoModel({@required this.title, this.iconUrl, this.progress});
}

class JourneyInfoTileModel extends UIWidgetTypeModel {
  final int type;
  final JourneyInfoModel data;

  JourneyInfoTileModel({@required this.type, this.data});
}
