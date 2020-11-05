import 'package:flutter/material.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors().accent1,
      child: Center(
        child: SpinKitWanderingCubes(
          color: AppColors().primary,
        ),
      ),
    );
  }
}

class LoadingText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      child: Center(
        child: SpinKitThreeBounce(
          color: AppColors().primary,
        ),
      ),
    );
  }
}