import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/shared/UI_components/transparent_appbar_and_navbar.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.dark),
    );
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, '/mainpage');
    });
  }

  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            splashScreenLogo(),
          ],
        ),
      ),
    );
  }
  //========================= main function =========================

  ClipRRect splashScreenLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        "assets/img/UI/logo.jpg",
        height: 200,
        width: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
