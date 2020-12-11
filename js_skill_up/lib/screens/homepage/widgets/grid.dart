import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/journey_info_tile.dart';

class SkillUpGrid extends StatelessWidget {
  final int colCount;
  final List<UIWidgetTypeModel> items;

  SkillUpGrid({this.colCount, this.items});

  factory SkillUpGrid.gridWith2cols({items}) {
    return SkillUpGrid(
      colCount: 2,
      items: items,
    );
  }

  factory SkillUpGrid.gridWith3cols({items}) {
    return SkillUpGrid(
      colCount: 3,
      items: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: this.colCount,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        padding: EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: widgetBuilder());
  }

  List<dynamic> widgetBuilder() {
    return this.items.map(
      (UIWidgetTypeModel e) {
        if (e.type == UIWidgetTypes.JOURNEY_INFO_TILE &&
            (e is JourneyInfoTileModel)) {
          return JourneyInfoTile(
            tileData: e,
          );
        }
        return null;
      },
    ).toList(growable: false);
  }
}
