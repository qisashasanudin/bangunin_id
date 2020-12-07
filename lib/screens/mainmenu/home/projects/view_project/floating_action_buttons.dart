import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/services/upload_picture.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDialChild addPictureButton(
    BuildContext context, String userID, String projectID) {
  return SpeedDialChild(
    backgroundColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Icon(Icons.add_a_photo, color: AppColors().accent1),
    label: 'Tambah Foto Baru',
    onTap: () async {
      UploadPicture(
          context: context,
          docId: projectID,
          table: 'accounts/$userID/projects/',
          attribute: 'gallery',
          storagePath: '/accounts/$userID/projects/$projectID/gallery');
    },
  );
}

SpeedDialChild editProjectButton(
    BuildContext context, ProjectDetailsModel information, var materials) {
  return SpeedDialChild(
    elevation: 10,
    backgroundColor: Theme.of(context).primaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Icon(Icons.settings, color: AppColors().accent1),
    label: 'Edit Proyek',
    onTap: () {
      chooseEditProject(context, information, materials);
    },
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
        await DatabaseService(uid: userID, docId: details.projectId)
            .deleteProjectData();
      }
    },
  );
}

Future<void> chooseEditProject(BuildContext context,
    ProjectDetailsModel information, var materials) async {
  final action = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: GestureDetector(
                  child: Text('Rincian Proyek'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/projectinformation',
                        arguments: information);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: GestureDetector(
                  child: Text('Material Proyek'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/projectmaterials',
                        arguments: [information, materials]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  return action;
}
