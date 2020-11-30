import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/dynamic_multi_form.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';

class NewProjectMaterials extends StatefulWidget {
  @override
  _NewProjectMaterialsState createState() => _NewProjectMaterialsState();
}

class _NewProjectMaterialsState extends State<NewProjectMaterials> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();
  List<MaterialModel> materialsList = [];

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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ProjectDetailsCard(child: details),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Divider(color: Colors.black)),
                //TODO: Materials checklist
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: DynamicMultiForm(
                    returnValue: getMaterialListData,
                  ),
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

  getMaterialListData(List<MaterialModel> _materialList) {
    setState(() {
      materialsList = List.from(_materialList);
    });
  }

  _uploadData(ProjectDetailsModel projectDetails) async {
    if (_formKey.currentState.validate()) {
      setState(() {
        projectDetails.dateCreated = DateTime.now();
        projectDetails.isCompleted = false;
      });
      String docId = await DatabaseService(uid: AuthService().getCurrentUID())
          .createProjectData('accounts', 'projects', {
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

      for (var element in materialsList)
        await DatabaseService(uid: AuthService().getCurrentUID())
            .createProjectMaterialsData(
                'accounts', 'projects', docId, 'materials_target', {
          'name': element.name,
          'size': element.size,
          'type': element.type,
          'unit': element.unit,
          'price': element.price,
          'amount': element.amount,
          'image': element.image,
        });
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }
}
