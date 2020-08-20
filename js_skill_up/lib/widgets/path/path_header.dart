import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/redux/models/app_state.dart';
import 'package:js_skill_up/redux/reducers/path_detail_reducer.dart';
import 'package:redux/redux.dart';

class PathHeaderWidget extends StatelessWidget {
  final double progressValue;

  PathHeaderWidget({this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(blurRadius: 1)]),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            StoreConnector<AppState, Store<AppState>>(
                converter: (store) => store,
                builder: (BuildContext context, Store<AppState> store) {
                  return IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      store.dispatch(
                        PathDetailStartPathAction(),
                      );
                    },
                  );
                }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
