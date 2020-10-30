import 'package:bangunin_id/screens/authentication/register.dart';
import 'package:bangunin_id/screens/authentication/sign_in.dart';
import 'package:bangunin_id/screens/home/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:provider/provider.dart';

class MainMenuWrapper extends StatefulWidget {
  @override
  _MainMenuWrapperState createState() => _MainMenuWrapperState();
}

class _MainMenuWrapperState extends State<MainMenuWrapper> {
  bool signInScreen = true;
  void toggleView() {
    setState(() => signInScreen = !signInScreen);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either SignIn, Register, or Home widget
    if (user == null) {
      if (signInScreen == true) {
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
    } else {
      return MainMenu();
    }
  }
}
