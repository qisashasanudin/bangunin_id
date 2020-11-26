import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

SizedBox submitButton(promptText, onPressed) {
  return SizedBox(
    width: double.infinity,
    child: RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: AppColors().primary,
      child: Text(promptText, style: TextStyle(color: AppColors().accent1)),
      onPressed: onPressed,
    ),
  );
}
