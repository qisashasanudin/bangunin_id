import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/UI_components/custom_heading.dart';

class CheckoutTab extends StatefulWidget {
  //Settings({Key key}) : super(key: key);
  @override
  _CheckoutTabState createState() => _CheckoutTabState();
}

class _CheckoutTabState extends State<CheckoutTab> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeading(
              title: 'Your Order',
            ),
            // widget-widget lain dimasukkan di sini
          ],
        ),
      ),
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
