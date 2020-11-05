import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:flutter/material.dart';

class AccountTab extends StatefulWidget {
  //Account({Key key}) : super(key: key);
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
      builder: (context, snapshot) {
        return SlideUpPanel(
          children: [
            SliverToBoxAdapter(
              child: pullDownMarker(),
            ),
            (!snapshot.hasData)
                ? (SliverToBoxAdapter(child: LoadingScreen()))
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
        onTap: () async {},
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Nama'),
        subtitle: Text(snapshot.data.data()['name']),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'name';
          bottomSheetTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.email),
        title: Text('Email'),
        subtitle: Text(snapshot.data.data()['email']),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'email';
          bottomSheetTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text('Nomor Telepon'),
        subtitle: Text(snapshot.data.data()['phone'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'phone';
          bottomSheetTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Alamat'),
        subtitle: Text(snapshot.data.data()['address'] ?? 'Belum diisi'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'address';
          bottomSheetTextForm(context, snapshot, attribute);
        },
      ),
      ListTile(
        leading: Icon(Icons.lock),
        title: Text('Ganti Password'),
        trailing: Icon(Icons.edit),
        onTap: () async {
          String attribute = 'password';
          bottomSheetTextForm(context, snapshot, attribute);
        },
      ),
    ]);
  }

  Future bottomSheetTextForm(context, snapshot, String attribute) async {
    final _formKey = GlobalKey<FormState>();
    String _currentValue = snapshot.data.data()[attribute];

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
                  TextFormField(
                      initialValue: _currentValue,
                      decoration:
                          inputBoxBorder().copyWith(hintText: attribute),
                      validator: (val) =>
                          (val.isEmpty) ? 'Data tidak boleh kosong' : null,
                      onChanged: (val) => setState(() => _currentValue = val)),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: AppColors().primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Simpan',
                        style: TextStyle(color: AppColors().accent1),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(
                                  uid: AuthService().getCurrentUID())
                              .updateAccountData(
                                  attribute,
                                  _currentValue ??
                                      snapshot.data.data()[attribute]);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
