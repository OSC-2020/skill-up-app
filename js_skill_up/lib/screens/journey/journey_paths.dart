import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:js_skill_up/constants/ui_standards.dart';
import 'package:js_skill_up/services/redux/models/journeys/journey_detail.dart';
import 'package:js_skill_up/services/redux/models/journeys/paths/path_detail.dart';

class JourneyPathsScreen extends StatefulWidget {
  JourneyPathsScreen();

  @override
  _JourneyPathsScreenState createState() => _JourneyPathsScreenState();
}

class _JourneyPathsScreenState extends State<JourneyPathsScreen> {
  ScrollController scrollController;

  final JourneyDetailModel journeyInfo = new JourneyDetailModel(
    totalPaths: 12,
    paths: [
      PathDetailModel(title: 'Title 1'),
      PathDetailModel(title: 'Title 2'),
      PathDetailModel(title: 'Title 3'),
      PathDetailModel(title: 'Title 4'),
      PathDetailModel(title: 'Title 5'),
      PathDetailModel(title: 'Title 6'),
      PathDetailModel(title: 'Title 7'),
      PathDetailModel(title: 'Title 8'),
      PathDetailModel(title: 'Title 9'),
      PathDetailModel(title: 'Title 10'),
      PathDetailModel(title: 'Title 11'),
      PathDetailModel(title: 'Title 12'),
    ].toList(growable: false),
  );

  @override
  void initState() {
    super.initState();
    this.scrollController = new ScrollController();
  }

  @override
  dispose() {
    super.dispose();
    this.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: when a user has completed half of the chapters, make listview scroll to that chapter(at center)
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.grid_on),
        onPressed: () {
          this.scrollToBottom();
        },
      ),
      body: Container(
        color: Colors.cyanAccent,
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          reverse: true,
          controller: this.scrollController,
          itemCount: this.journeyInfo.totalPaths,
          itemBuilder: (BuildContext context, int index) {
            if (index == this.journeyInfo.totalPaths - 1) {
              this.scrollToBottom();
            }
            return this.generateListItem(index);
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: UIStandards.STANDARD_GAP,
          ),
        ),
      ),
    );
  }

  generateListItem(int index) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: getDynamicAlignment(index),
      child: Card(
        child: ListTile(
          title: Text(this.journeyInfo.paths[index].title),
        ),
      ),
    );
  }

  getDynamicAlignment(int index) {
    int pos = index % 4;
    if (pos == 0) {
      return Alignment.centerLeft;
    } else if (pos == 1 || pos == 3) {
      return Alignment.center;
    }
    return Alignment.centerRight;
  }

  scrollToBottom() {
    if (this.scrollController.position.minScrollExtent != null) {
      scrollController.animateTo(
        this.scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 10),
        curve: Curves.easeInOut,
      );
    }
  }
}
