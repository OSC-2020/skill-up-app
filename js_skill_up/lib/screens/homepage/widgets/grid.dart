import 'package:flutter/material.dart';
import 'package:js_skill_up/screens/homepage/widgets/journey_info_tile.dart';

class SkillUpGrid extends StatelessWidget {
  final int colCount;
  final List items;

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

  List<JourneyInfoTile> widgetBuilder() {
    return this
        .items
        .map(
          (e) => JourneyInfoTile(),
        )
        .toList(growable: false);
  }
}
