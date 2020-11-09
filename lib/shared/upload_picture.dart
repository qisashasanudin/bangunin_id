import 'dart:io';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadPicture {
  final BuildContext context;
  final String storagePath;

  UploadPicture({@required this.context, this.storagePath}) {
    chooseImageSource(context);
  }

  final userID = AuthService().getCurrentUID();
  var picker = ImagePicker();
  PickedFile imageFile;
  File croppedImageFile;

  Future<void> chooseImageSource(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GestureDetector(
                    child: Text('Camera'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      imageFile = await getImageFromExtApp(context, 'Camera');
                      croppedImageFile = await cropImage(picker);
                      await uploadImage(croppedImageFile);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GestureDetector(
                    child: Text('Gallery'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      imageFile = await getImageFromExtApp(context, 'Gallery');
                      croppedImageFile = await cropImage(picker);
                      await uploadImage(croppedImageFile);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getImageFromExtApp(BuildContext context, String appType) async {
    Map<Permission, PermissionStatus> allStatus =
        await [Permission.camera, Permission.storage].request();
    if (allStatus[Permission.camera].isGranted) {
      if (allStatus[Permission.storage].isGranted) { 
        var picture = await picker.getImage(
            source: (appType == 'Camera')
                ? ImageSource.camera
                : ImageSource.gallery);
        return picture;
      } else {
        Fluttertoast.showToast(
          msg:
              "Please grant permission to access microphone for recording video.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please grant permission to access camera.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  Future cropImage(picker) async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      maxHeight: 512,
      maxWidth: 512,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: AppColors().primary,
        toolbarWidgetColor: AppColors().accent1,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        aspectRatioLockEnabled: true,
      ),
    );
    return cropped;
  }

  uploadImage(source) async {
    await FirebaseStorage.instance.ref().child(storagePath).putFile(source);
  }
}
