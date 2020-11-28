import 'package:flutter/material.dart';

InputDecoration formFieldDecoration(labelText) {
  return InputDecoration(
    isDense: true,
    labelText: labelText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}
