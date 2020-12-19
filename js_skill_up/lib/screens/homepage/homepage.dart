import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/screens/homepage/widgets/grid_with_title.dart';
import 'package:js_skill_up/services/redux/middleware/books/books_groups.middleware.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.dart';
import 'package:js_skill_up/services/redux/reducers/books/current_book.reducer.dart';

import '../../global_keys.dart';

typedef void SaveToStoreCallback(BookInfoModel bookInfoModel);

class HomeScreen extends StatefulWidget {
  final void Function() checkUserLogin;

  HomeScreen({this.checkUserLogin});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SaveToStoreCallback _getSaveToStoreCallBack() {
    return (BookInfoModel book) {
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(BookGroupSelectBookAction(selectedBook: book));
      GlobalKeys.navKey.currentState.pushNamed(
        AppRoutes.BOOK_CHAPTERS,
        arguments: book.id,
      );
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.checkUserLogin != null) {
      //TODO: Move this to splash screen.
      widget.checkUserLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            StoreConnector<AppState, List<BookGroupsModel>>(converter: (store) {
          List<BookGroupsModel> bookGroups = store.state.bookGroups;
          if (bookGroups == null) {
            store.dispatch(loadBookGroupsFromDBMiddleware);
          }
          return bookGroups;
        }, builder: (context, List<BookGroupsModel> groups) {
          SaveToStoreCallback callback = _getSaveToStoreCallBack();
          if (groups == null) {
            return Center(
              child: Text(
                'I am loading',
                style: Theme.of(context).textTheme.headline4,
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: generateHomePageFeed(groups, callback),
            ),
          );
        }),
      ),
    );
  }

  generateHomePageFeed(
      List<BookGroupsModel> groups, SaveToStoreCallback callback) {
    return groups.map((BookGroupsModel group) {
      if (group.uiType == UIWidgetTypes.GRID) {
        return SkillUpGridWithTitle(
          title: group.title,
          items: group.books,
          clickCallback: (UIWidgetTypeModel item) {
            assert(callback != null);
            callback(item);
          },
        );
      }
      return Text('Dev error: UI widget not configured');
    }).toList(growable: false);
  }
}
