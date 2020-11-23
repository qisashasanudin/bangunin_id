import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  //Settings({Key key}) : super(key: key);
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SlideUpPanel(
      children: [
        CustomAppBar(
          title: 'Pengaturan',
        ),
        signOutButton(),
        language(),
        // widget-widget lain dimasukkan di sini
      ],
    );
  }

  ListTile signOutButton() {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Keluar'),
      onTap: () async {
        await _auth.signOut();
      },
    );
  }

  ListTile language() {
    return ListTile(
      leading: Icon(Icons.language),
      title: Text('Bahasa'),
      subtitle: Text('Indonesia'),
      onTap: () {}, // command yang dilakukan jika tombol ditekan
    );
  }
}
