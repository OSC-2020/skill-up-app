import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/services/redux/middleware/books/book_chapters.middleware.dart';
import 'package:js_skill_up/services/redux/models/app_state.model.dart';
import 'package:js_skill_up/services/redux/models/books/book_detail.model.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/reducers/books/current_chapter.reducer.dart';

import '../../global_keys.dart';
import '../../routes.dart';

typedef void SaveToStoreCallback(ChapterInfoModel chapterInfo);

class BookChaptersScreen extends StatefulWidget {
  final String bookID;

  BookChaptersScreen({this.bookID});

  @override
  _BookChaptersScreenState createState() => _BookChaptersScreenState();
}

class _BookChaptersScreenState extends State<BookChaptersScreen> {
  ScrollController scrollController;

  SaveToStoreCallback _getSaveToStoreCallBack() {
    return (ChapterInfoModel chapter) {
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(BookChaptersSelectChapterAction(selectedChapter: chapter));
      GlobalKeys.navKey.currentState.pushNamed(
        AppRoutes.CHAPTER_DETAIL,
        arguments: chapter.id,
      );
    };
  }

  @override
  void initState() {
    super.initState();
    this.scrollController = new ScrollController();
  }

  @override
  dispose() {
    super.dispose();
    this.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: when a user has completed half of the chapters, make listview scroll to that chapter(at center)
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.grid_on),
          onPressed: () {
            this.scrollToBottom();
          },
        ),
        backgroundColor: Colors.cyanAccent,
        body: SafeArea(
          child: StoreConnector<AppState, BookDetailModel>(
            converter: (store) {
              if (store.state.bookChaptersMap.containsKey(widget.bookID) &&
                  store.state.bookChaptersMap[widget.bookID] != null) {
                return store.state.bookChaptersMap[widget.bookID];
              }
              store
                  .dispatch(loadChaptersForBookFromDBMiddleware(widget.bookID));
              return null;
            },
            builder: (context, BookDetailModel bookDetail) {
              if (bookDetail == null) {
                return Center(
                  child: Text(
                    'I am loading',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }

              SaveToStoreCallback callback = this._getSaveToStoreCallBack();
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    shrinkWrap: true,
                    reverse: true,
                    controller: this.scrollController,
                    itemCount: bookDetail.totalChapters,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == bookDetail.totalChapters - 1) {
                        this.scrollToBottom();
                      }
                      return this.generateListItem(bookDetail, index, callback);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: UIStandards.STANDARD_GAP,
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  generateListItem(
      BookDetailModel bookDetail, int index, SaveToStoreCallback callback) {
    return GestureDetector(
      onTap: () {
        assert(callback != null);
        callback(bookDetail.chapters[index]);
      },
      child: FractionallySizedBox(
        widthFactor: 0.7,
        alignment: getDynamicAlignment(index),
        child: Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(bookDetail.chapters[index].title ?? ""),
                (bookDetail.chapters[index].isCompleted ?? false)
                    ? Icon(Icons.check_circle)
                    : Text("")
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDynamicAlignment(int index) {
    int pos = index % 4;
    if (pos == 0) {
      return Alignment.centerLeft;
    } else if (pos == 1 || pos == 3) {
      return Alignment.center;
    }
    return Alignment.centerRight;
  }

  scrollToBottom() {
    if (this.scrollController.position.minScrollExtent != null) {
      scrollController.animateTo(
        this.scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
    }
  }
}
