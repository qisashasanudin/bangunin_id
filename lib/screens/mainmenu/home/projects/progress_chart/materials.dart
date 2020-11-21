import 'package:flutter/material.dart';

class MaterialModel {
  MaterialModel(this.name, {@required this.amount});

  final String name;
  final double amount;
}

final materials = [
  MaterialModel('Pasir', amount: 40),
  MaterialModel('Keramik', amount: 80),
  MaterialModel('Batu Bata', amount: 100),
  MaterialModel('Semen', amount: 40),
  MaterialModel('In-Progress', amount: 140),
];
