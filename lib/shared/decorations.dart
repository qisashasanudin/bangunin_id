import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  fillColor: Colors.grey[350],
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey[350], width: 3.0),
    borderRadius: BorderRadius.circular(100),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow[700], width: 3.0),
    borderRadius: BorderRadius.circular(100),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.circular(100),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.yellow[700], width: 3.0),
    borderRadius: BorderRadius.circular(100),
  ),
);

var logo = ClipRRect(
  borderRadius: BorderRadius.circular(16.0),
  child: Image.asset(
    "assets/img/logo.jpg",
    height: 120,
    width: 120,
    fit: BoxFit.fill,
  ),
);

var authenticationBackground = BoxDecoration(
  image: DecorationImage(
    alignment: Alignment.bottomCenter,
    image: AssetImage('assets/img/auth_bg.jpg'),
    colorFilter:
        new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
  ),
);
