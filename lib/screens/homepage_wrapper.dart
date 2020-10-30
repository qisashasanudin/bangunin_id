import 'package:bangunin_id/screens/authentication/register.dart';
import 'package:bangunin_id/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/home/home.dart';
import 'package:provider/provider.dart';

class HomepageWrapper extends StatefulWidget {
  @override
  _HomepageWrapperState createState() => _HomepageWrapperState();
}

class _HomepageWrapperState extends State<HomepageWrapper> {
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
      return Home();
    }
  }
}
