import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/scrollmenu.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return ScrollMenu(
      children: [
        SliverToBoxAdapter(
          child: pullDownMarker(),
        ),
        SliverList(
          delegate: signOutButton(),
        )
      ],
    );
  }

  SliverChildListDelegate signOutButton() {
    return SliverChildListDelegate([
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Keluar'),
        onTap: signOut,
      ),
    ]);
  }

  void signOut() async {
    await _auth.signOut();
  }
}
