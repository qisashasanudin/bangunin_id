import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:flutter/material.dart';

class ShopTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  @override
  Widget build(BuildContext context) {
    return SlideUpPanel(
      children: [
        slideUpMarker(),
        // widget-widget lain dimasukkan di sini
      ],
    );
  }
}
