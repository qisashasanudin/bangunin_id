import 'package:bangunin_id/screens/authenticate/register.dart';
import 'package:bangunin_id/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/home/home.dart';
import 'package:provider/provider.dart';

class ScreenWrapper extends StatefulWidget {
  @override
  _ScreenWrapperState createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either SignIn, Register, or Home widget
    if (user == null) {
      if (showSignIn == true) {
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
    } else {
      return Home();
    }
  }
}
