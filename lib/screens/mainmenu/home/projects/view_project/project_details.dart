import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
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
    ProjectDetailsModel details = ModalRoute.of(context).settings.arguments;

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entityDocumentSnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPage(
          // backgroundImage: Image.asset(
          //   'assets/img/UI/sliver_page_bg.jpg',
          //   fit: BoxFit.cover,
          // ),
          title: Text('Proyek ${details.projectName}'),
          children: [
            SliverList(
              delegate: SliverChildListDelegate([
                projectDetails(details),
                separatorLine(),
                overallProgress(0.75),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (_, builder) {
                    return itemProgress(context, 'Material', 0.50);
                  },
                ),
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

Padding projectDetails(ProjectDetailsModel details) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: ProjectDetailsCard(child: details),
  );
}

Padding separatorLine() {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Divider(color: Colors.black));
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
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
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
