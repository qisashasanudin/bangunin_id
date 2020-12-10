import 'package:bangunin_id/screens/mainmenu/shop/categories/category_b.dart';
import 'package:bangunin_id/screens/mainmenu/shop/categories/category_a.dart';
import 'package:bangunin_id/screens/mainmenu/shop/categories/category_c.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';
import 'package:flutter/material.dart';

class ShopTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _ShopTabState createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return SlideUpPanel(
      children: [
        DefaultTabController(
          length: 6,
          child: Column(
            children: <Widget>[
              CustomAppBar(
                title: 'Beli Material',
                searchButton: true,
                cartButton: true,
                onTapCartButton: () async {
                  Navigator.of(context).pushNamed('/tabcheckout');
                },
              ),
              categories(),
              SizedBox(height: 5),
              itemList(context),
              //Scaffold(
              //floatingActionButton: FloatingActionButton(
              // onPressed: () {},
              // child: Text('Checkout'),
              // ),),
            ],
          ),
        ),
        // widget-widget lain dimasukkan di sini
      ],
      floatingButton: createProjectButton(context),
    );
  }
  //========================= main function =========================
}

TabBar categories() {
  return TabBar(
    isScrollable: true,
    labelColor: AppColors().primary,
    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    unselectedLabelColor: Colors.grey,
    unselectedLabelStyle: TextStyle(fontSize: 16),
    tabs: <Widget>[
      Tab(child: Text("Kategori A")),
      Tab(child: Text("Kategori B")),
      Tab(child: Text("Kategori C")),
      Tab(child: Text("Kategori D")),
      Tab(child: Text("Kategori E")),
      Tab(child: Text("Kategori F")),
    ],
  );
}

Container itemList(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 5,
    child: TabBarView(
      children: <Widget>[
        CategoryA(),
        CategoryB(),
        CategoryC(),
        CategoryA(),
        CategoryB(),
        CategoryC(),
      ],
    ),
  );
}

FloatingActionButton createProjectButton(BuildContext context) {
  return FloatingActionButton.extended(
    elevation: 10,
    icon: Icon(Icons.shopping_cart, color: AppColors().accent1),
    label: Text('Checkout', style: TextStyle(color: AppColors().accent1)),
    onPressed: () async {
      Navigator.of(context).pushNamed('/tabcheckout');
    },
  );
}
