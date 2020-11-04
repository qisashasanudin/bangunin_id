import 'package:bangunin_id/screens/mainmenu/account/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/home/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/settings/tab_settings.dart';
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
        backgroundColor: AppColors().primary,
        body: PageStorage(
          bucket: bucket,
          child: TabBarView(
            children: <Widget>[
              Home(
                  //key: PageStorageKey('Beranda'),
                  ),
              Account(
                  //key: PageStorageKey('Akun'),
                  ),
              Settings(
                  //key: PageStorageKey('Pengaturan'),
                  ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors().accent1,
          child: TabBar(
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
      ),
    );
  }
}
