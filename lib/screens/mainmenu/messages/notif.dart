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
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: <Widget>[
            CustomHeading(
              title: 'Tracking Orders',
            ),
            _trackingOrder('Cat Merah', 'Rp. 150.000,00', 'Deliver'),
            _trackingOrder('Pintu', 'Rp. 10.000,00', 'Deliver'),
            _trackingOrder('Lemari', 'Rp. 3.000.000,00', 'Arrived'),
            _trackingOrder('Batu Bata', 'Rp. 10.000,00', 'Arrived'),
          ],
        ),
      ),
    );
  }

  Container _trackingOrder(String judul, String harga, String deliver) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            ExpansionTile(
              leading: Icon(
                Icons.local_shipping,
                size: 20,
                color: Colors.black38,
              ),
              title: Text('Tracking Details',
                  style: TextStyle(color: Colors.black38, fontSize: 15)),
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.orangeAccent,
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          '[Jakarta] on process',
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45.0, 5.0, 10.0, 5.0),
                      child: Text(
                        '29-03-2010   19:54',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.grey[300],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          '[Jakarta Utara] received on process',
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45.0, 5.0, 10.0, 5.0),
                      child: Text(
                        '26-03-2010   17:00',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on_rounded,
                          color: Colors.grey[300],
                        ),
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text(
                          '[Cikarang.Bekasi] manifested',
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(45.0, 5.0, 10.0, 5.0),
                      child: Text(
                        '25-03-2010   15:33',
                        style: TextStyle(fontSize: 12, color: Colors.black38),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
