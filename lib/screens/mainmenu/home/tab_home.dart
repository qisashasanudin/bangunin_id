import 'package:flutter/material.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';
import 'package:bangunin_id/screens/mainmenu/home/project_list.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();
    var myProjects = Provider.of<List<ProjectDetailsModel>>(context) ?? [];
    var myOngoingProjects =
        myProjects.where((project) => project.isCompleted == false) ?? [];
    var myCompletedProjects =
        myProjects.where((project) => project.isCompleted == true) ?? [];

    return SlideUpPanel(
      children: [
        CustomAppBar(
          title: 'Beranda',
          searchButton: true,
          sortButton: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: projectCounter(myOngoingProjects, 'Sedang Berjalan')),
            Expanded(child: projectCounter(myCompletedProjects, 'Selesai')),
          ],
        ),
        ProjectList(children: myProjects),
        // widget-widget lain dimasukkan di sini
      ],
      floatingButton: createProjectButton(userID),
    );
  }
  //========================= main function =========================
}

ListTile projectCounter(projects, subtitle) {
  return ListTile(
    title: Center(
        child: Text(projects.length.toString(),
            style: TextStyle(fontWeight: FontWeight.bold))),
    subtitle: Center(child: Text(subtitle)),
  );
}

StreamBuilder createProjectButton(String userID) {
  return StreamBuilder(
    stream: DatabaseService(uid: userID).entityDocumentSnapshot('accounts'),
    builder: (context, snapshot) {
      if (snapshot.hasData &&
          ((snapshot.data.data()['role'] == 'Administrator') ||
              (snapshot.data.data()['role'] == 'Mandor'))) {
        return FloatingActionButton.extended(
          elevation: 10,
          onPressed: () => _popupToUploadCsv(context),
          label: Text(
            'Buat Proyek Baru',
            style: TextStyle(color: AppColors().accent1),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        );
      } else {
        return Container();
      }
    },
  );
}

Future<void> _popupToUploadCsv(BuildContext context) async {
  final action = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Buat Proyek Baru'),
        content: Text('Apakah anda sudah memiliki file BoQ?'),
        actions: [
          RaisedButton(
            color: Colors.green,
            child: Text(
              'Import File .csv',
              style: TextStyle(color: AppColors().accent1),
            ),
            onPressed: () {
              Navigator.pop(context);
              // TODO: upload file CSV
              // Navigator.of(context).pushNamed('/projectinformation');
            },
          ),
          FlatButton(
            child: Text(
              'Input Manual',
              style: TextStyle(color: AppColors().accent2),
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/projectinformation');
            },
          ),
        ],
      );
    },
  );
  return action;
}
