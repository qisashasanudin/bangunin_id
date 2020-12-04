import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/existing_project/weekly_progress.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
                        flex: 3,
                        child: ProjectDetailsCard(child: details),
                      ),
                    ],
                  ),
                ),
                //TODO: tambah opsi untuk mengganti pekan
                WeeklyProgress(items: materialsTarget),
              ]),
            ),
            //sliver-sliver lain ditulis di sini
          ],
          floatingButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: AppColors().accent1,
            elevation: 10,
            children: [
              addPictureButton(context),
              editProjectButton(context),
              deleteProjectButton(context, userID, details),
            ],
          ),
        );
      },
    );
  }

  //========================= main function =========================

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

  SpeedDialChild addPictureButton(BuildContext context) {
    return SpeedDialChild(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(Icons.add_a_photo, color: AppColors().accent1),
      label: 'Tambah Foto Baru',
      onTap: () {},
    );
  }

  SpeedDialChild editProjectButton(BuildContext context) {
    return SpeedDialChild(
      elevation: 10,
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(Icons.settings, color: AppColors().accent1),
      label: 'Edit Proyek',
      onTap: () {},
    );
  }

  SpeedDialChild deleteProjectButton(
      BuildContext context, String userID, ProjectDetailsModel details) {
    return SpeedDialChild(
      elevation: 10,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Icon(Icons.delete, color: AppColors().accent1),
      label: 'Hapus Proyek',
      onTap: () async {
        final action = await PopUpDialog.yesNoDialog(context, 'Hapus Proyek',
            'Apakah anda yakin ingin menghapus proyek ini?');
        if (action == DialogAction.yes) {
          Navigator.of(context).pop();
          await DatabaseService(uid: userID, projectId: details.projectId)
              .deleteProjectData();
        }
      },
    );
  }
}
