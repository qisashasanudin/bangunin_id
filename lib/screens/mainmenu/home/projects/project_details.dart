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
              delegate: SliverChildListDelegate([
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
                buildCategoryCard(Icons.fastfood, "Semen", 120, 20),
                buildCategoryCard(Icons.flash_on, "Pasir", 430, 17),
                buildCategoryCard(Icons.fastfood, "Batu", 120, 20),
                buildCategoryCard(Icons.fastfood, "Batu", 120, 20),
              ]),
            ),
          ],
        );
      },
    );
  }
}

Container buildCategoryCard(
    IconData icon, String title, int amount, int percentage) {
  return Container(
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    height: 85,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Color(0xFF00B686),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "\$$amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "($percentage%)",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Stack(
          children: [
            Container(
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.grey.shade300),
            ),
            Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0XFF00B686)),
            ),
          ],
        )
      ],
    ),
  );
}
