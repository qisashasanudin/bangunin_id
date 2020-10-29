import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffc000),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.logout, color: Colors.white),
            label: Text('Keluar', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
    );
  }
}
