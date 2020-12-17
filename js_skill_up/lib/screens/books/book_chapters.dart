import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/services/db/books/book_chapters.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/books/book_detail.dart';
import 'package:js_skill_up/services/redux/models/books/chapters/chapter_detail.dart';
import 'package:js_skill_up/services/redux/reducers/books/book_chapters.dart';
import 'package:redux/redux.dart';

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
  BookDetailModel bookDetail;
  bool showLoader = true;

  SaveToStoreCallback _getSaveToStoreCallBack(Store<AppState> store) {
    return (ChapterInfoModel chapter) {
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
    BookChapterDB.getAllChapters(widget.bookID)
        .then((DocumentSnapshot snapshot) {
      this.bookDetail = new BookDetailModel.fromMap(snapshot.data());
      setState(() {
        this.showLoader = false;
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    this.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: when a user has completed half of the chapters, make listview scroll to that chapter(at center)
    print('Loading chapters for ID : ${widget.bookID}');
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.grid_on),
          onPressed: () {
            this.scrollToBottom();
          },
        ),
        backgroundColor: Colors.cyanAccent,
        body: SafeArea(
          child: StoreConnector<AppState, SaveToStoreCallback>(
            converter: (store) => this._getSaveToStoreCallBack(store),
            builder: (context, SaveToStoreCallback callback) {
              return this.showLoader
                  ? Center(
                      child: Text(
                        'I am loading',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    )
                  : Column(
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
                          itemCount: this.bookDetail.totalChapters,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == this.bookDetail.totalChapters - 1) {
                              this.scrollToBottom();
                            }
                            return this.generateListItem(index, callback);
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

  generateListItem(int index, SaveToStoreCallback callback) {
    return GestureDetector(
      onTap: () {
        assert(callback != null);
        callback(this.bookDetail.chapters[index]);
      },
      child: FractionallySizedBox(
        widthFactor: 0.7,
        alignment: getDynamicAlignment(index),
        child: Card(
          child: ListTile(
            title: Text(this.bookDetail.chapters[index].title),
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
