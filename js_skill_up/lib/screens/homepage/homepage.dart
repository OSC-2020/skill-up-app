import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/routes.dart';
import 'package:js_skill_up/screens/homepage/widgets/grid_with_title.dart';
import 'package:js_skill_up/services/db/books/book_groups.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_groups.dart';
import 'package:redux/redux.dart';

import '../../global_keys.dart';

typedef void SaveToStoreCallback(BookInfoModel bookInfoModel);

class HomeScreen extends StatefulWidget {
  final void Function() checkUserLogin;

  HomeScreen({this.checkUserLogin});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showLoader = true;
  List<BookGroupsModel> bookGroups;

  SaveToStoreCallback _getSaveToStoreCallBack(Store<AppState> store) {
    return (BookInfoModel book) {
      store.dispatch(BookGroupSelectBookAction(selectedBook: book));
      GlobalKeys.navKey.currentState.pushNamed(AppRoutes.BOOK_CHAPTERS);
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.checkUserLogin != null) {
      //TODO: Move this to splash screen.
      widget.checkUserLogin();
    }
    BookGroupsDB.getAllBookGroups().then((snapshot) {
      this.bookGroups = new List<BookGroupsModel>();
      snapshot.docs.forEach((doc) {
        this.bookGroups.add(BookGroupsModel.fromMap(doc.data()));
      });
      this.setState(() {
        this.showLoader = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StoreConnector<AppState, SaveToStoreCallback>(
            converter: (store) => this._getSaveToStoreCallBack(store),
            builder: (context, SaveToStoreCallback callback) {
              return this.showLoader
                  ? Center(
                      child: Text(
                        'I am loading',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: generateHomePageFeed(callback),
                      ),
                    );
            }),
      ),
    );
  }

  generateHomePageFeed(SaveToStoreCallback callback) {
    return this.bookGroups.map((BookGroupsModel group) {
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
