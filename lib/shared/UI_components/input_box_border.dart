import 'package:flutter/material.dart';

InputDecoration inputBoxBorder(labelText) {
  return InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
