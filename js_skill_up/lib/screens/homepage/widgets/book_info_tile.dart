import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/constants/ui_widget_types.dart';

class BookInfoTile extends StatelessWidget {
  BookInfoTileModel tileData;

  BookInfoTile({this.tileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UIStandards.BOOK_CARD_HEIGHT,
      width: UIStandards.BOOK_CARD_HEIGHT,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey.shade200.withOpacity(0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: <Widget>[
                this.tileData.data.iconUrl != null
                    ? Image.asset(
                        this.tileData.data.iconUrl,
                        fit: BoxFit.cover,
                      )
                    : Text(""),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    this.tileData.data.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          this.tileData.data.progress != null
              ? LinearProgressIndicator(
                  value: this.tileData.data.progress,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                  backgroundColor: Colors.white10,
                )
              : Text(""),
        ],
      ),
    );
  }
}
