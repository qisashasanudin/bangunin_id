import 'package:bangunin_id/screens/mainmenu/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/tab_settings.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class MainMenuNav extends StatefulWidget {
  @override
  _MainMenuNavState createState() => _MainMenuNavState();
}

class _MainMenuNavState extends State<MainMenuNav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Settings(),
    Account(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primary,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors().accent1,
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
