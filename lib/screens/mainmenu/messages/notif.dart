import 'package:bangunin_id/shared/UI_components/custom_heading.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomHeading(
              title: 'Tracking Orders',
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
