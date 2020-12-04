import 'package:bangunin_id/screens/mainmenu/messages/messages.dart';
import 'package:bangunin_id/screens/mainmenu/messages/notif.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/custom_appbar.dart';
import 'package:bangunin_id/shared/page_templates/slide_up_panel.dart';
import 'package:flutter/material.dart';

class MessagesAndNotifTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _MessagesAndNotifTabState createState() => _MessagesAndNotifTabState();
}

class _MessagesAndNotifTabState extends State<MessagesAndNotifTab> {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return SlideUpPanel(
      children: [
        DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              CustomAppBar(
                title: 'Pesan dan Notifikasi',
                searchButton: true,
                sortButton: true,
              ),
              categories(),
              SizedBox(height: 5),
              itemList(context),
            ],
          ),
        ),
        // widget-widget lain dimasukkan di sini
      ],
    );
  }
  //========================= main function =========================
}

TabBar categories() {
  return TabBar(
    labelColor: AppColors().primary,
    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    unselectedLabelColor: Colors.grey,
    unselectedLabelStyle: TextStyle(fontSize: 16),
    tabs: <Widget>[
      Tab(child: Text("Pesan")),
      Tab(child: Text("Notifikasi")),
    ],
  );
}

Container itemList(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.6,
    child: TabBarView(
      children: <Widget>[
        Messages(),
        Notif(),
      ],
    ),
  );
}
