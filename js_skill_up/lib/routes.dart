import 'package:flutter/material.dart';
import 'package:js_skill_up/screens/books/book_chapters.dart';
import 'package:js_skill_up/screens/chapter/chapter_detail.dart';
import 'package:js_skill_up/screens/homepage/homepage.dart';
import 'package:js_skill_up/screens/login/login.dart';

class AppRoutes {
  static const String LOGIN = '/login';
  static const String HOMEPAGE = '/homepage';
  static const String BOOK_CHAPTERS = '/bookChapters';
  static const String CHAPTER_DETAIL = '/chapterDetail';
}

Route<dynamic> handleRoute(RouteSettings routeSettings) {
  List<String> nameParam = routeSettings.name.split(";");
  assert(nameParam.length >= 1);
  String routeName = nameParam[0];
  assert(routeName != null);
  Widget childWidget;
  switch (routeName) {
    case AppRoutes.LOGIN:
      childWidget = LoginScreen();
      break;
    case AppRoutes.HOMEPAGE:
      childWidget = HomeScreen();
      break;
    case AppRoutes.BOOK_CHAPTERS:
      final String bookID = routeSettings.arguments;
      childWidget = BookChaptersScreen(
        bookID: bookID,
      );
      break;
    case AppRoutes.CHAPTER_DETAIL:
      final String chapterID = routeSettings.arguments;
      childWidget = ChapterDetailScreen(
        chapterID: chapterID,
      );
      break;
    default:
      throw new Exception('Routing error! No route mapped.');
  }
  return MaterialPageRoute(builder: (context) => childWidget);
}
