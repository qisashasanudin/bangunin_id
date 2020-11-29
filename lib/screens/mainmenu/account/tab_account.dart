import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/UI_components/form_field_decoration.dart';
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

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entityDocumentSnapshot('accounts'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SlideUpPanel(
            children: [LoadingScreen()],
          );
        }
        return SlideUpPanel(
          children: [
            CustomAppBar(title: 'Akun'),
            _changeProfilePic(context),
            _userInfo(snapshot, context, Icons.person, 'Nama', 'name'),
            _userInfo(snapshot, context, Icons.phone, 'Telepon', 'phone'),
            _userInfo(snapshot, context, Icons.home, 'Alamat', 'address'),
            _changeEmail(snapshot),
            _changePassword(),
            // widget-widget lain dimasukkan di sini
          ],
        );
      },
    );
  }
  //========================= main function =========================

  ListTile _changeProfilePic(BuildContext context) {
    return ListTile(
      title: Text('Ganti Foto Profil'),
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

  ListTile _userInfo(snapshot, context, leadingIcon, title, attribute) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: Text(snapshot.data.data()[attribute] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () async {
        _popUpTextForm(context, snapshot, attribute);
      },
    );
  }

  //TODO: request to Firebase Auth to change email
  ListTile _changeEmail(snapshot) {
    return ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text(snapshot.data.data()['email'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () async {},
    );
  }

  //TODO: request to Firebase Auth to change password
  ListTile _changePassword() {
    return ListTile(
      leading: Icon(Icons.lock),
      title: Text('Ganti Password'),
      trailing: Icon(Icons.edit),
      onTap: () async {},
    );
  }

  Future _popUpTextForm(context, snapshot, String attribute) async {
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
                  _editText(attribute),
                  SizedBox(height: 20.0),
                  _updateButton(snapshot, attribute, 'Simpan'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField _editText(String attribute) {
    return TextFormField(
      keyboardType:
          (attribute == 'phone') ? TextInputType.number : TextInputType.text,
      initialValue: currentValue,
      decoration: formFieldDecoration(attribute),
      validator: (val) => (val.isEmpty) ? 'Data tidak boleh kosong' : null,
      onChanged: (val) => setState(() => currentValue = val),
    );
  }

  SizedBox _updateButton(snapshot, String attribute, String prompt) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () async {
          _uploadData(snapshot, attribute, currentValue);
        },
      ),
    );
  }

  _uploadData(snapshot, attribute, data) async {
    if (_formKey.currentState.validate()) {
      await DatabaseService(uid: AuthService().getCurrentUID()).writeData(
          'accounts', attribute, data ?? snapshot.data.data()[attribute]);
      Navigator.pop(context);
    }
  }
}
