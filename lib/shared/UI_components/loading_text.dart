import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Center(
        child: SpinKitThreeBounce(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
