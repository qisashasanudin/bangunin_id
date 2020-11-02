import 'package:bangunin_id/screens/mainmenu/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/tab_settings.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class MainMenuTabNav extends StatefulWidget {
  @override
  _MainMenuTabNavState createState() => _MainMenuTabNavState();
}

class _MainMenuTabNavState extends State<MainMenuTabNav> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(
            children: <Widget>[
              Home(key: PageStorageKey('Beranda')),
              Account(key: PageStorageKey('Akun')),
              Settings(key: PageStorageKey('Pengaturan')),
            ],
          ),
        ),
        bottomNavigationBar: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.settings)),
          ],
          labelColor: AppColors().primary,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors().primary, width: 4.0),
            insets: EdgeInsets.only(bottom: 44),
          ),
          unselectedLabelColor: AppColors().accent3,
        ),
      ),
    );
  }
}
