import 'package:bangunin_id/models/material_model.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:bangunin_id/shared/UI_components/on_back_pressed.dart';
import 'package:bangunin_id/shared/UI_components/project_details_card.dart';
import 'package:bangunin_id/shared/UI_components/project_material_form.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';

class NewProjectMaterials extends StatefulWidget {
  @override
  _NewProjectMaterialsState createState() => _NewProjectMaterialsState();
}

class _NewProjectMaterialsState extends State<NewProjectMaterials> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();
  List<MaterialModel> unselectedMaterials = List.from(materials);
  List<MaterialModel> selectedMaterials = [];
  List<ProjectMaterialForm> generatedList = [];
  String error = '';

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    ProjectDetailsModel details = ModalRoute.of(context).settings.arguments;

    return WillPopScope(
      onWillPop: () async => await onBackPressed(context),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: _list(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _addObjectButton(),
                      _deleteObjectButton(),
                    ],
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ),
              ]),
            ), //sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }

  //========================= main function =========================

  ListView _list() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: generatedList.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: generatedList[index],
        );
      },
    );
  }

  Flexible _addObjectButton() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new DropdownButton(
          hint: Text('Tambah material'),
          items: [
            for (var object in unselectedMaterials)
              new DropdownMenuItem(
                value: object,
                child: Text(
                    '${object.name ?? ''} ${object.size ?? ''} ${object.type ?? ''}'),
              )
          ],
          onChanged: (value) {
            if (unselectedMaterials.isEmpty) {
              return;
            }
            setState(() {
              selectedMaterials.add(value);
              unselectedMaterials.removeWhere((element) => element == value);
              generatedList.add(ProjectMaterialForm(
                children: value,
                returnValue: _getNewObject,
              ));
            });
          },
        ),
      ),
    );
  }

  _getNewObject(MaterialModel newObject) {
    setState(() {
      selectedMaterials[selectedMaterials.indexWhere((oldObject) =>
          oldObject.name == newObject.name &&
          oldObject.type == newObject.type &&
          oldObject.size == newObject.size)] = newObject;
    });
  }

  Flexible _deleteObjectButton() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomButton(
          prompt: 'Hapus',
          onPressed: () {
            if (selectedMaterials.isEmpty) {
              return;
            }
            setState(() {
              unselectedMaterials.add(selectedMaterials.last);
              selectedMaterials.removeLast();
              generatedList.removeLast();
            });
          },
        ),
      ),
    );
  }

  _uploadData(ProjectDetailsModel projectDetails) async {
    bool status = true;
    for (var i in generatedList) {
      status = i.isValid() && status;
    }
    if (_formKey.currentState.validate() &&
        status &&
        selectedMaterials.isNotEmpty) {
      String docId = await DatabaseService(
        uid: AuthService().getCurrentUID(),
      ).createProjectData(
        {
          'projectName': projectDetails.projectName,
          'address': projectDetails.address,
          'addressGMap': projectDetails.addressGMap,
          'clientName': projectDetails.clientName,
          'clientEmail': projectDetails.clientEmail,
          'clientPhone': projectDetails.clientPhone,
          'dateCreated': projectDetails.dateCreated ?? DateTime.now(),
          'dateDeadline': projectDetails.dateDeadline,
          'isCompleted': projectDetails.isCompleted ?? false,
        },
      );
      for (var element in selectedMaterials) {
        await DatabaseService(
          uid: AuthService().getCurrentUID(),
          projectId: docId,
        ).createProjectMaterialsData(
          'materials_target',
          {
            'name': element.name,
            'size': element.size,
            'type': element.type,
            'unit': element.unit,
            'price': element.price,
            'amount': element.amount,
            'image': element.image,
          },
        );
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      setState(() {
        error = 'Material tidak boleh kosong.';
      });
    }
  }
}
