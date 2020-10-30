import 'package:bangunin_id/screens/authentication/register.dart';
import 'package:bangunin_id/screens/authentication/sign_in.dart';
import 'package:bangunin_id/screens/home/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:provider/provider.dart';

class MainPageWrapper extends StatefulWidget {
  @override
  _MainPageWrapperState createState() => _MainPageWrapperState();
}

class _MainPageWrapperState extends State<MainPageWrapper> {
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
      return MainPage();
    }
  }
}
