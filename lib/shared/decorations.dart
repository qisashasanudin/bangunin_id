import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  final primary = const Color(0xffffc000);
  final accent1 = Colors.white;
  final accent2 = Colors.black;
  final accent3 = Colors.grey[300];
  AppColors();
}

final chartColors = [
  Color.fromRGBO(82, 98, 255, 1), //  rgb(82, 98, 255)
  Color.fromRGBO(46, 198, 255, 1), // rgb(46, 198, 255)
  Color.fromRGBO(123, 201, 82, 1), // rgb(123, 201, 82)
  Color.fromRGBO(255, 171, 67, 1), // rgb(255, 171, 67)
  Color.fromRGBO(252, 91, 57, 1), //  rgb(252, 91, 57)
  Color.fromRGBO(139, 135, 130, 1), //rgb(139, 135, 130)
];

SystemUiOverlayStyle transparentAppbarAndNavbar() {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

Center slideUpMarker() {
  return Center(
    child: Container(
      height: 8,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors().accent3,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

ClipRRect loginLogo() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.asset(
      "assets/img/logo.jpg",
      height: 120,
      width: 120,
      fit: BoxFit.fill,
    ),
  );
}

BoxDecoration loginBground() {
  return BoxDecoration(
    image: DecorationImage(
      alignment: Alignment.bottomCenter,
      image: AssetImage('assets/img/auth_bg.jpg'),
      colorFilter: new ColorFilter.mode(
          Colors.black.withOpacity(0.4), BlendMode.dstATop),
    ),
  );
}

InputDecoration inputBoxBorder() {
  return InputDecoration(
    fillColor: Colors.grey[350],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[350], width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
  );
}
