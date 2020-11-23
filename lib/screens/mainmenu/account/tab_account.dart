import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/input_box_border.dart';
import 'package:bangunin_id/shared/UI_components/loading_screen.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';
import 'package:bangunin_id/services/upload_picture.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatefulWidget {
  //Account({Key key}) : super(key: key);
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  final _formKey = GlobalKey<FormState>();
  final userID = AuthService().getCurrentUID();
  String currentValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SlideUpPanel(
            children: [LoadingScreen()],
          );
        }
        return SlideUpPanel(
          tabTitle: 'Akun',
          children: [
            userProfilePic(context),
            userInfo(snapshot, context, Icons.person, 'Nama', 'name'),
            userInfo(snapshot, context, Icons.phone, 'Telepon', 'phone'),
            userInfo(snapshot, context, Icons.home, 'Alamat', 'address'),
            changeEmail(snapshot),
            changePassword(),
            // widget-widget lain dimasukkan di sini
          ],
        );
      },
    );
  }

  ListTile userProfilePic(BuildContext context) {
    return ListTile(
      title: Text('Foto Profil'),
      trailing: Icon(Icons.edit),
      onTap: () async {
        UploadPicture(
            context: context,
            table: 'accounts',
            attribute: 'profilePicture',
            storagePath: '/accounts/$userID/profilePicture/profilePicture.jpg');
      },
    );
  }

  ListTile userInfo(snapshot, context, leadingIcon, title, attribute) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: Text(snapshot.data.data()[attribute] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () async {
        popUpTextForm(context, snapshot, attribute);
      },
    );
  }

  ListTile changeEmail(snapshot) {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text(snapshot.data.data()['email'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () async {},
    );
  }

  ListTile changePassword() {
    return ListTile(
      leading: Icon(Icons.lock),
      title: Text('Ganti Password'),
      trailing: Icon(Icons.edit),
      onTap: () async {},
    );
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
                  editText(attribute),
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

  TextFormField editText(String attribute) {
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
      await DatabaseService(uid: AuthService().getCurrentUID()).updateData(
          'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.pop(context);
    }
  }
}
