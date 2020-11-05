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
}

SliverChildListDelegate accountDetails(context, snapshot) {
  return SliverChildListDelegate([
    ListTile(
      title: Text('Foto Profil'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.person),
      title: Text('Nama'),
      subtitle: Text(snapshot.data.data()['name']),
      trailing: Icon(Icons.edit),
      onTap: () {
        String attribute = 'nama';
        bottomSheetTextForm(context, attribute);
      },
    ),
    ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text(snapshot.data.data()['email']),
      trailing: Icon(Icons.edit),
      onTap: () {
        String attribute = 'email';
        bottomSheetTextForm(context, attribute);
      },
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Telepon'),
      subtitle: Text(snapshot.data.data()['phone'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () {
        String attribute = 'phone';
        bottomSheetTextForm(context, attribute);
      },
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text('Alamat'),
      subtitle: Text(snapshot.data.data()['address'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () {
        String attribute = 'address';
        bottomSheetTextForm(context, attribute);
      },
    ),
    ListTile(
      leading: Icon(Icons.lock),
      title: Text('Ganti Password'),
      trailing: Icon(Icons.edit),
      onTap: () {
        String attribute = 'password';
        bottomSheetTextForm(context, attribute);
      },
    ),
  ]);
}

Future bottomSheetTextForm(context, String attribute) async {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: Text(attribute),
      );
    },
  );
}
