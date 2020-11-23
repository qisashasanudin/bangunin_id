import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';

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
