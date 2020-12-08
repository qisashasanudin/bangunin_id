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
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomHeading(
                  title: 'Your Order',
                ),
                Text(
                  'Add Items + ',
                  style: TextStyle(
                      color: Colors.orangeAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // widget-widget lain dimasukkan di sini
          ],
        ),
      ),
    );
  }
  //========================= main function =========================

  Container _trackingOrder(String judul, String harga, String deliver) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  judul,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                  ),
                ),
                Text(
                  deliver,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    '5 Desember 2020 \n5 pail',
                    style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
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
