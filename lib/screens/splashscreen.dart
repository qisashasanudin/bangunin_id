import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/screens/main_page_wrapper.dart';
import '../shared/decorations.dart';
import 'main_page_wrapper.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageWrapper()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
