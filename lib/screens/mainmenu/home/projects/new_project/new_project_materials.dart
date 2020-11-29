import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewProjectMaterials extends StatefulWidget {
  @override
  _NewProjectMaterialsState createState() => _NewProjectMaterialsState();
}

class _NewProjectMaterialsState extends State<NewProjectMaterials> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    ProjectDetailsModel details = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Form(
        key: _formKey,
        child: SliverPage(
          // backgroundImage: Image.asset(
          //   'assets/img/UI/new_project_bg.jpg',
          //   fit: BoxFit.cover,
          // ),
          title: Text('Material Proyek'),
          children: [
            SliverList(
              delegate: SliverChildListDelegate([
                //widget-widget lain dipasang di sini
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ProjectDetailsCard(child: details),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CustomButton(
                      prompt: 'Simpan',
                      onPressed: () {
                        _uploadData(details);
                      }),
                ),
              ]),
            ), //sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }

  //========================= main function =========================

  Future<bool> _onBackPressed() async {
    bool tappedYes = false;
    final action = await PopUpDialog.yesNoDialog(context, 'Kembali?',
        'Apakah anda yakin ingin kembali? Semua pengaturan pada halaman ini tidak akan tersimpan.');
    if (action == DialogAction.yes) {
      tappedYes = true;
    }
    return tappedYes;
  }

  _uploadData(ProjectDetailsModel projectDetails) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        projectDetails.dateCreated = DateTime.now();
        projectDetails.isCompleted = false;
      });
      await DatabaseService(uid: AuthService().getCurrentUID())
          .createDataOnSubcollection('accounts', 'projects', {
        'projectName': projectDetails.projectName,
        'address': projectDetails.address,
        'addressGMap': projectDetails.addressGMap,
        'clientName': projectDetails.clientName,
        'clientEmail': projectDetails.clientEmail,
        'clientPhone': projectDetails.clientPhone,
        'dateCreated': projectDetails.dateCreated,
        'dateDeadline': projectDetails.dateDeadline,
        'isCompleted': projectDetails.isCompleted,
      });
      //TODO: upload materials information
      // await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
      //     'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }
}
