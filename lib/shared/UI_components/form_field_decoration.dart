import 'package:flutter/material.dart';

InputDecoration formFieldDecoration(labelText) {
  return InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
