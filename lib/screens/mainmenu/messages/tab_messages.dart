import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';

class MessagesTab extends StatefulWidget {
  //Settings({Key key}) : super(key: key);
  @override
  _MessagesTabState createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return SlideUpPanel(
      children: [
        CustomAppBar(
          title: 'Pesan dan Notifikasi',
        ),
        // widget-widget lain dimasukkan di sini
      ],
    );
  }
  //========================= main function =========================
}
