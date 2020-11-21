import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/services/auth.dart';

class ShopTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return SlideUpPanel(
      children: [
        SliverToBoxAdapter(
          child: pullDownMarker(),
        ),
        // sliver-sliver lain dimasukkan di sini
      ],
    );
  }
}
