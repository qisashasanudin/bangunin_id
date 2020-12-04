import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';

class CheckoutTab extends StatefulWidget {
  //Settings({Key key}) : super(key: key);
  @override
  _CheckoutTabState createState() => _CheckoutTabState();
}

class _CheckoutTabState extends State<CheckoutTab> {
  final AuthService _auth = AuthService();

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

  ListTile language() {
    return ListTile(
      leading: Icon(Icons.language),
      title: Text('Bahasa'),
      subtitle: Text('Indonesia'),
      onTap: () {}, // command yang dilakukan jika tombol ditekan
    );
  }
}
