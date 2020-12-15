import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/book_info_tile.dart';

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
        children: generateWidgets());
  }

  List<dynamic> generateWidgets() {
    return this.items.map(
      (UIWidgetTypeModel e) {
        if (e.type == UIWidgetTypes.BOOK_INFO_TILE &&
            (e is BookInfoTileModel)) {
          return BookInfoTile(
            tileData: e,
          );
        }
        return null;
      },
    ).toList(growable: false);
  }
}
