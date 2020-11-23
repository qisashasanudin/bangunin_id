import 'package:flutter/material.dart';

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
