import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

RaisedButton customButton(promptText, onPressed) {
  return RaisedButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: AppColors().primary,
    child: Text(promptText, style: TextStyle(color: AppColors().accent1)),
    onPressed: onPressed,
  );
}
