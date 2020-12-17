import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/grid.dart';

class SkillUpGridWithTitle extends StatelessWidget {
  final String title;
  final int colCount;
  final List<UIWidgetTypeModel> items;
  final GridItemClickCallback clickCallback;

  SkillUpGridWithTitle({
    @required this.title,
    @required this.clickCallback,
    this.colCount = 2,
    this.items,
  }) {
    assert(this.colCount == 2 || this.colCount == 3);
    assert(this.items.length > 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 4.0,
          ),
          child: Text(
            this.title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
          height: UIStandards.STANDARD_GAP,
        ),
        this.colCount == 2
            ? SkillUpGrid.gridWith2cols(
                items: this.items,
                callback: this.clickCallback,
              )
            : SkillUpGrid.gridWith3cols(
                items: this.items,
                callback: this.clickCallback,
              )
      ],
    );
  }
}
