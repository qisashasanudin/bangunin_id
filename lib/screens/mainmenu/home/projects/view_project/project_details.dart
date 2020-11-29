import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProjectDetails extends StatelessWidget {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entityDocumentSnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPage(
          // backgroundImage: Image.asset(
          //   'assets/img/UI/sliver_page_bg.jpg',
          //   fit: BoxFit.cover,
          // ),
          title: Text('Rincian Proyek'),
          children: [
            SliverList(
              delegate: SliverChildListDelegate([
                // informasi-informasi proyek ditulis di sini
                overallProgress(0.75),
                itemProgress(context, 'Pasir', 0.40),
                itemProgress(context, 'Keramik', 0.80),
                itemProgress(context, 'Batu Bata', 1.00),
                itemProgress(context, 'Semen', 0.45),
                itemProgress(context, 'Cat', 0.75),
                itemProgress(context, 'Kayu', 0.10),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
        );
      },
    );
  }
  //========================= main function =========================
}

Padding overallProgress(percentage) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: CircularPercentIndicator(
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.greenAccent,
      animation: true,
      radius: 200,
      lineWidth: 20,
      percent: percentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Overall',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${percentage * 100}%',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

SizedBox itemProgress(BuildContext context, itemType, percentage) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              itemType,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            progressColor: Theme.of(context).primaryColor,
            animation: true,
            lineHeight: 30,
            percent: percentage,
            center: Text('${percentage * 100}%',
                style: TextStyle(color: AppColors().accent1)),
          ),
        ],
      ),
    ),
  );
}
