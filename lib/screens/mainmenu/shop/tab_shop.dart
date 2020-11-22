import 'package:bangunin_id/screens/mainmenu/shop/categories/category_b.dart';
import 'package:bangunin_id/screens/mainmenu/shop/categories/category_a.dart';
import 'package:bangunin_id/screens/mainmenu/shop/categories/category_c.dart';
import 'package:bangunin_id/shared/UI_templates.dart'; // sumber AppColors()
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
        SlideUpMarker(),
        Container(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: <Widget>[
                SearchBar(textHint: 'Cari'),
                TabBar(
                  labelColor: AppColors().primary,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(fontSize: 16),
                  tabs: <Widget>[
                    Tab(child: Text("Kategori A")),
                    Tab(child: Text("Kategori B")),
                    Tab(child: Text("Kategori C")),
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    children: <Widget>[
                      CategoryA(),
                      CategoryB(),
                      CategoryC(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // widget-widget lain dimasukkan di sini
      ],
    );
  }
}
