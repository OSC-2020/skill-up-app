import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/grid_with_title.dart';
import 'package:js_skill_up/services/redux/models/app_state.dart';
import 'package:js_skill_up/services/redux/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  final void Function() checkUserLogin;

  HomeScreen({this.checkUserLogin});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return StoreConnector<AppState, UserModel>(
      converter: (store) => store.state.user,
      builder: (context, UserModel user) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  generateHomePageFeed(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  generateHomePageFeed() {
    List data = [
      {'type': CommonWidgetTypes.JOURNEY_INFO_TILE},
      {'type': CommonWidgetTypes.JOURNEY_INFO_TILE},
      {'type': CommonWidgetTypes.JOURNEY_INFO_TILE},
      {'type': CommonWidgetTypes.JOURNEY_INFO_TILE},
    ];
    return new SkillUpGridWithTitle(items: data);
  }
}
