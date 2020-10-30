import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primary,
      appBar: AppBar(
        title: Text('Pengaturan'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[],
      ),
    );
  }
}
