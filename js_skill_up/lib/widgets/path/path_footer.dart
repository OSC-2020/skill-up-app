import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/path_detail_reducer.dart';
import 'package:redux/redux.dart';

class PathFooterWidget extends StatelessWidget {
  final String explanationString;

  PathFooterWidget({this.explanationString = ""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: this.explanationString.length > 0
                  ? Text(this.explanationString)
                  : Container()),
          StoreConnector<AppState, Store<AppState>>(
              converter: (store) => store,
              builder: (BuildContext context, Store<AppState> store) {
                return FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    store.dispatch(
                      PathDetailNextPageAction(store.state.currentPath),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
