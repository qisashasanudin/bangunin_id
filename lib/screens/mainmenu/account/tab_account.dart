import 'dart:io';

import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AccountTab extends StatefulWidget {
  //Account({Key key}) : super(key: key);
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();
  String currentValue;

  var picker = ImagePicker();
  PickedFile imageFile;
  File croppedImageFile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
      builder: (context, snapshot) {
        return SlideUpPanel(
          children: [
            SliverToBoxAdapter(
              child: pullDownMarker(),
            ),
            (!snapshot.hasData)
                ? (SliverToBoxAdapter(child: LoadingText()))
                : (SliverList(
                    delegate: accountDetails(context, snapshot),
                  )),
          ],
        );
      },
    );
  }

  SliverChildListDelegate accountDetails(context, snapshot) {
    return SliverChildListDelegate([
      ListTile(
        title: Text('Foto Profil'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          chooseImageSource(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Nama'),
        subtitle: Text(snapshot.data.data()['name'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'name';
          popUpTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text('Nomor Telepon'),
        subtitle: Text(snapshot.data.data()['phone'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'phone';
          popUpTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Alamat'),
        subtitle: Text(snapshot.data.data()['address'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'address';
          popUpTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text('Email'),
        subtitle: Text(snapshot.data.data()['email'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(Icons.lock),
        title: Text('Ganti Password'),
        trailing: Icon(Icons.edit),
        onTap: () async {},
      ),
    ]);
  }

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
                      await getImageFromExtApp(context, 'Camera');
                      await cropImage(picker);
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
                      await getImageFromExtApp(context, 'Gallery');
                      await cropImage(picker);
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
    var picture = await picker.getImage(
        source:
            (appType == 'Camera') ? ImageSource.camera : ImageSource.gallery);
    setState(() {
      imageFile = picture;
    });
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
    setState(() {
      croppedImageFile = cropped;
    });
  }

  uploadImage(source) {
    setState(() {
      FirebaseStorage.instance
          .ref()
          .child('accounts/$userID/profilePicture/profilePicture.jpg')
          .putFile(source);
    });
  }

  Future popUpTextForm(context, snapshot, String attribute) async {
    currentValue = snapshot.data.data()[attribute];

    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              height: 200,
              child: ListView(
                children: <Widget>[
                  editForm(attribute),
                  SizedBox(height: 20.0),
                  submitButton(snapshot, attribute, 'Simpan'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField editForm(String attribute) {
    return TextFormField(
        initialValue: currentValue,
        decoration: inputBoxBorder().copyWith(hintText: attribute),
        validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong' : null,
        onChanged: (val) => setState(() => currentValue = val));
  }

  SizedBox submitButton(snapshot, String attribute, String prompt) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: AppColors().primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () async {
          uploadData(snapshot, attribute, currentValue);
        },
      ),
    );
  }

  void uploadData(snapshot, attribute, data) async {
    if (_formKey.currentState.validate()) {
      await DatabaseService(uid: AuthService().getCurrentUID())
          .updateAccountData(
              attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.pop(context);
    }
  }
}
