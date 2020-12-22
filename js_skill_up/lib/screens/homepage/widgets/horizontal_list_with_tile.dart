import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';
import 'package:js_skill_up/screens/homepage/widgets/horizontal_list.dart';

class SkillUpHorizontalListWithTitle extends StatelessWidget {
  final String title;
  final List<UIWidgetTypeModel> items;

  SkillUpHorizontalListWithTitle({@required this.title, this.items}) {
    assert(this.items.length > 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.title ?? "",
                style: Theme.of(context).textTheme.headline5,
              ),
              Text('')
            ],
          ),
          SizedBox(
            height: UIStandards.STANDARD_GAP,
          ),
          new SkillUpHorizontalList(
            items: this.items,
          ),
        ],
      ),
    );
  }
}
