import 'package:flutter/material.dart';

class FullscreenProfilePicture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var picture = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        child: picture,
      ),
    );
  }
}
