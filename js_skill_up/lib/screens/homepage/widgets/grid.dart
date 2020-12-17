import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/book_info_tile.dart';
import 'package:js_skill_up/services/redux/models/books/book_groups.dart';

typedef GridItemClickCallback(UIWidgetTypeModel item);

class SkillUpGrid extends StatelessWidget {
  final int colCount;
  final List<UIWidgetTypeModel> items;
  final GridItemClickCallback clickCallback;

  SkillUpGrid({
    @required this.colCount,
    @required this.clickCallback,
    this.items,
  }) {
    assert(this.clickCallback != null);
  }

  factory SkillUpGrid.gridWith2cols({
    List<UIWidgetTypeModel> items,
    @required GridItemClickCallback callback,
  }) {
    return SkillUpGrid(
      colCount: 2,
      items: items,
      clickCallback: callback,
    );
  }

  factory SkillUpGrid.gridWith3cols({
    List<UIWidgetTypeModel> items,
    @required GridItemClickCallback callback,
  }) {
    return SkillUpGrid(
      colCount: 3,
      items: items,
      clickCallback: callback,
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

  Widget makeClickableWidget(Widget widget, UIWidgetTypeModel data) {
    return GestureDetector(
      onTap: () {
        this.clickCallback(data);
      },
      child: widget,
    );
  }

  List<dynamic> generateWidgets() {
    return this.items.map(
      (UIWidgetTypeModel book) {
        if (book.uiType == UIWidgetTypes.BOOK_INFO_TILE &&
            (book is BookInfoModel)) {
          return this.makeClickableWidget(
            BookInfoTile(
              tileData: book,
            ),
            book,
          );
        }
        print('Dev Error! No Widget Assigned');
        return null;
      },
    ).toList(growable: false);
  }
}
