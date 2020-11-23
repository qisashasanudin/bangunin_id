import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

InputDecoration inputBoxBorder() {
  return InputDecoration(
    fillColor: Colors.grey[350],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[350], width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors().primary, width: 3.0),
      borderRadius: BorderRadius.circular(100),
    ),
  );
}
