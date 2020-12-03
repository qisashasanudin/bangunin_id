import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
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
                      Flexible(flex: 1, child: overallProgress(0.50)),
                      SizedBox(width: 15),
                      Flexible(
                          flex: 3, child: ProjectDetailsCard(child: details)),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                    //masukkan tulisan
                    ),
                Container(
                  height: 250,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      myArticles("assets/img/UI/home_bg_default4.jpg",
                          "Perbaikan Atap Rumah", "perbaikan atap rumah"),
                      myArticles("assets/img/UI/home_bg_default4.jpg",
                          "Perbaikan depan rumah", "perbaikan depan rumah"),
                      myArticles("assets/img/UI/home_bg_default4.jpg",
                          "Perbaikan depan rumah", "perbaikan depan rumah"),
                      myArticles("assets/img/UI/home_bg_default4.jpg",
                          "Perbaikan depan rumah", "perbaikan depan rumah"),
                      myArticles("assets/img/UI/home_bg_default4.jpg",
                          "Perbaikan depan rumah", "perbaikan depan rumah"),
                    ],
                  ),
                ),
                separatorLine(),
                FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: materialsTarget.length,
                  itemBuilder: (_, index) {
                    return itemProgress(context, materialsTarget[index], 0.50);
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

  Container myArticles(String imageVal, String heading, String subHeading) {
    return Container(
      width: 250.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10,
          shadowColor: Color(0x802196F3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Image.asset(imageVal),
              ListTile(
                title: Text(heading),
                subtitle: Text(subHeading),
              )
            ],
          ),
        ),
      ),
    );
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
