import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/book_info_tile.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.dart';

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
    print('***I have got ${this.items}');

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
      (UIWidgetTypeModel book) {
        if (book.uiType == UIWidgetTypes.BOOK_INFO_TILE &&
            (book is BookInfoModel)) {
          return BookInfoTile(
            tileData: book,
          );
        }
        print('Dev Error! No Widget Assigned');
        return null;
      },
    ).toList(growable: false);
  }
}
