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
      currentPath: PathDetailModel(
        containsContent: true,
        id: "1",
        title: 'Introduction',
        content: [
          PathContentModel(content: [
            ContentDetailModel(content: 'Hi I am First', contentType: 1)
          ], footerHelpText: 'yay this works 1'),
          PathContentModel(content: [
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
          PathContentModel(content: [
            ContentDetailModel(content: 'Hi I am Third', contentType: 1)
          ], footerHelpText: 'yay this works 3'),
          PathContentModel(content: [
            ContentDetailModel(content: 'Hi I am Fourth', contentType: 1)
          ], footerHelpText: 'yay this works 4'),
          PathContentModel(content: [
            ContentDetailModel(content: 'Hi I am Second', contentType: 1)
          ], footerHelpText: 'yay this works 2'),
        ],
      ),
    );
  }
}
