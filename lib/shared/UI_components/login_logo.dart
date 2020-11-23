import 'package:flutter/material.dart';

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
