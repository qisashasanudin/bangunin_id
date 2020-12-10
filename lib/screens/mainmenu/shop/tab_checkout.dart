import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/UI_components/custom_heading.dart';
import 'package:bangunin_id/screens/mainmenu/messages/tab_messages_and_notif.dart';

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
            _checkoutSummary('Pasir Merah', 'Rp. 150.000,00', '50 pack'),
            _checkoutSummary('Pintu Toilet', 'Rp. 1.000.000,00', '5 pintu'),
            _checkoutSummary('Pipa Besi', 'Rp. 150.000,00', '50 pack'),
            _checkoutSummary('Semen Tiga Roda', 'Rp. 660.000,00', '10 pack'),
            CustomHeading(
              title: 'Summary',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Harga tertera hanya merupakan estimasi, \n Barang tidak dapat dikembalikan setelah dibeli',
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            ),
            _checkoutPrice('Subtotal', 'Rp.1.960.000,00', FontWeight.normal),
            _checkoutPrice(
                'Delivery fee \n1.2 km', 'Rp.150.000,00', FontWeight.normal),
            _checkoutPrice('Tax', 'Rp.40.000,00', FontWeight.normal),
            _checkoutPrice('Total', 'Rp.2.150.000,00', FontWeight.w900),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            ),
            CustomButton(
                icon: Icon(Icons.shopping_bag, color: AppColors().accent1),
                prompt: 'Konfirmasi Pesanan',
                onPressed: () async {
                  Navigator.pop(context);
                  //TODO: arahkan ke tab notifikasi
                }),
            // widget-widget lain dimasukkan di sini
          ],
        ),
      ),
    );
  }
  //========================= main function =========================

  Container _checkoutSummary(String judul, String harga, String deliver) {
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
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                    '5 Desember 2020 \ndari Tb Central Bangunan',
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

  Container _checkoutPrice(String judul, String harga, FontWeight tebal) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    judul,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: tebal,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    harga,
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: tebal,
                      fontSize: 16,
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
