import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ProjectDetails extends StatelessWidget {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();
    ProjectDetailsModel details = ModalRoute.of(context).settings.arguments;

    return MultiProvider(
        providers: [
          StreamProvider<List<MaterialModel>>.value(
            value: DatabaseService(uid: userID, projectId: details.projectId)
                .projectMaterialsTarget,
          ),
          // StreamProvider<List<MaterialModel>>.value(
          //   value: DatabaseService(uid: userID, projectId: details.projectId)
          //       .projectMaterialsProgress,
          // ),
        ],
        builder: (context, snapshot) {
          var materialsTarget = Provider.of<List<MaterialModel>>(context) ?? [];
          print(materialsTarget);
          // var materialsProgress = Provider.of<List<MaterialModel>>(context) ?? [];
          return SliverPage(
            // backgroundImage: Image.asset(
            //   'assets/img/UI/sliver_page_bg.jpg',
            //   fit: BoxFit.cover,
            // ),
            title: Text('Proyek ${details.projectName}'),
            children: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(flex: 1, child: overallProgress(0.75)),
                        SizedBox(width: 15),
                        Flexible(
                            flex: 3, child: ProjectDetailsCard(child: details)),
                      ],
                    ),
                  ),
                  separatorLine(),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: materialsTarget.length,
                    itemBuilder: (_, index) {
                      return itemProgress(
                          context, materialsTarget[index], 0.50);
                    },
                  ),
                ]),
              ),
              //sliver-sliver lain ditulis di sini
            ],
          );
        });
  }

  //========================= main function =========================
}

Padding separatorLine() {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Divider(color: Colors.black));
}

CircularPercentIndicator overallProgress(double percentage) {
  return CircularPercentIndicator(
    circularStrokeCap: CircularStrokeCap.round,
    progressColor: Colors.greenAccent,
    animation: true,
    radius: 100,
    lineWidth: 10,
    percent: percentage,
    center: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Overall',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${percentage * 100}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

SizedBox itemProgress(
    BuildContext context, MaterialModel item, double percentage) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '${item.name} ${item.size} ${item.type} (${item.amount} ${item.unit})',
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
