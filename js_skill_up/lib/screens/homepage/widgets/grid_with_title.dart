import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/grid.dart';

class SkillUpGridWithTitle extends StatelessWidget {
  final int colCount;
  final List<UIWidgetTypeModel> items;

  SkillUpGridWithTitle({this.colCount = 2, this.items}) {
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
            border: Border.all(width: 2.0, color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 4.0,
          ),
          child: Text(
            'I am heading',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        this.colCount == 2
            ? SkillUpGrid.gridWith2cols(items: this.items)
            : SkillUpGrid.gridWith3cols(items: this.items)
      ],
    );
  }
}
