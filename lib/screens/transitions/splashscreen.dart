import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/services.dart';
import '../../shared/decorations.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      Navigator.pushReplacementNamed(context, '/mainpage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: AppColors().primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              splashScreenLogo(),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect splashScreenLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        "assets/img/logo.jpg",
        height: 200,
        width: 200,
        fit: BoxFit.fill,
      ),
    );
  }
}
