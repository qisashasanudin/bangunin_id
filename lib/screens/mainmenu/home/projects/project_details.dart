import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/sliver_page.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/progress_chart/pie_chart.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/progress_chart/pie_chart_index.dart';

class ProjectDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPage(
          children: [
            SliverAppBar(
              stretch: true,
              pinned: true,
              expandedHeight: screenHeight / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Rincian Proyek'),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
              ),
            ),
            //sliver-sliver lain ditulis di sini
            SliverList(
              delegate: progressChart(context),
            ),
          ],
        );
      },
    );
  }

  SliverChildListDelegate progressChart(BuildContext context) {
    return SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Row(
            children: <Widget>[
              PieChartIndex(),
              PieChart(),
            ],
          ),
        ),
      ),
    ]);
  }
}
