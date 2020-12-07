import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/view_project/floating_action_buttons.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/view_project/overall_progress_percentage.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/view_project/weekly_progress.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class ProjectDetails extends StatefulWidget {
  //========================= main function =========================
  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();
    ProjectDetailsModel details =
        ModalRoute.of(context).settings.arguments ?? ProjectDetailsModel();

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
                      Flexible(flex: 1, child: overallProgressPercentage(0.50)),
                      SizedBox(width: 15),
                      Flexible(
                        flex: 3,
                        child: ProjectDetailsCard(child: details),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 5,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      _weeksTab(),
                      WeeklyProgress(items: materialsTarget),
                    ],
                  ),
                ),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
          floatingButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: AppColors().accent1,
            elevation: 10,
            children: [
              addPictureButton(context, userID, details.projectId),
              editProjectButton(context, details),
              deleteProjectButton(context, userID, details),
            ],
          ),
        );
      },
    );
  }
  //========================= main function =========================

  TabBar _weeksTab() {
    return TabBar(
      isScrollable: true,
      labelColor: AppColors().primary,
      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: TextStyle(fontSize: 16),
      tabs: <Widget>[
        Tab(child: Text("Pekan 1")),
        Tab(child: Text("Pekan 2")),
        Tab(child: Text("Pekan 3")),
        Tab(child: Text("Pekan 4")),
        Tab(child: Text("Pekan 5")),
      ],
      onTap: (value) {},
    );
  }
}
