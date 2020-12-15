import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/book_info_tile.dart';

class SkillUpHorizontalList extends StatelessWidget {
  final List<UIWidgetTypeModel> items;

  SkillUpHorizontalList({this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UIStandards.BOOK_CARD_HEIGHT,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: this.items.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: UIStandards.STANDARD_GAP,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (this.items[index].type == UIWidgetTypes.BOOK_INFO_TILE &&
              (this.items[index] is BookInfoTileModel)) {
            return BookInfoTile(
              tileData: this.items[index],
            );
          }
          return null;
        },
      ),
    );
  }

  generateWidgets() {
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
