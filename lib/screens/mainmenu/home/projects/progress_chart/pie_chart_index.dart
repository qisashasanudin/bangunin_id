import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/progress_chart/materials.dart';

class PieChartIndex extends StatelessWidget {
  const PieChartIndex({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (var category in materials)
            IndexDesc(text: category.name, index: materials.indexOf(category)),
        ],
      ),
    );
  }
}

class IndexDesc extends StatelessWidget {
  const IndexDesc({
    Key key,
    @required this.index,
    @required this.text,
  }) : super(key: key);

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: chartColors.elementAt(index % chartColors.length),
            ),
          ),
          SizedBox(width: 20),
          Text(text.capitalize()),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
