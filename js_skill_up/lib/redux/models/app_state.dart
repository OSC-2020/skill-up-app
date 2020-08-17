import 'package:flutter/foundation.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_base.dart';
import 'package:js_skill_up/redux/models/journeys/paths/base/path_content.dart';
import 'package:js_skill_up/redux/models/journeys/paths/path_detail.dart';
import 'package:js_skill_up/redux/models/user_model.dart';

@immutable
class AppState {
  final UserModel user;
  final PathDetailModel currentPath;

  AppState({@required this.user, this.currentPath});

  factory AppState.initial() {
    return AppState(
      user: null,
      currentPath: new PathDetailModel(
        containsContent: true,
        id: "1",
        title: 'Introduction',
        content: [
          new PathContentModel(content: [
            new ContentDetailModel(content: 'Hi I am First', contentType: 1)
          ], footerHelpText: 'yay this works 1'),
          new PathContentModel(content: [
            new ContentDetailModel(content: 'Hi I am Second', contentType: 1)
          ], footerHelpText: 'yay this works 2'),
          new PathContentModel(content: [
            new ContentDetailModel(content: 'Hi I am Third', contentType: 1)
          ], footerHelpText: 'yay this works 3'),
          new PathContentModel(content: [
            new ContentDetailModel(content: 'Hi I am Fourth', contentType: 1)
          ], footerHelpText: 'yay this works 4'),
          new PathContentModel(content: [
            new ContentDetailModel(content: 'Hi I am Second', contentType: 1)
          ], footerHelpText: 'yay this works 2'),
        ],
      ),
    );
  }
}
