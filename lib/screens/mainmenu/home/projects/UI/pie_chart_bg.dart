import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/UI/item_properties.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/UI/pie_chart.dart';

class PieChartBG extends StatelessWidget {
  const PieChartBG({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors().accent1,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: CustomPaint(
                    child: Center(),
                    foregroundPainter: PieChart(
                      width: constraints.maxWidth * 0.5,
                      categories: items,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: constraints.maxWidth * 0.4,
                  decoration: BoxDecoration(
                    color: AppColors().accent1,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: -2,
                        blurRadius: 10,
                        offset: Offset(5, 5),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('75%'),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
