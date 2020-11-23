import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';

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
