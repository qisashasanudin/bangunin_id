import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatefulWidget {
  //Account({Key key}) : super(key: key);
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<User>(context).uid;

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
                    delegate: accountDetails(snapshot),
                  )),
          ],
        );
      },
    );
  }
}

SliverChildListDelegate accountDetails(AsyncSnapshot snapshot) {
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
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.email),
      title: Text('Email'),
      subtitle: Text(snapshot.data.data()['email']),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('Telepon'),
      subtitle: Text(snapshot.data.data()['phone'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.home),
      title: Text('Alamat'),
      subtitle: Text(snapshot.data.data()['address'] ?? 'Belum diisi'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      leading: Icon(Icons.lock),
      title: Text('Ganti Password'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
  ]);
}
