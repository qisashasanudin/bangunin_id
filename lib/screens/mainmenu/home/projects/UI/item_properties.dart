import 'package:flutter/material.dart';

class ItemModel {
  ItemModel(this.name, {@required this.amount});

  final String name;
  final double amount;
}

final items = [
  ItemModel('Pasir', amount: 40),
  ItemModel('Keramik', amount: 80),
  ItemModel('Batu Bata', amount: 100),
  ItemModel('Semen', amount: 40),
  ItemModel('In-Progress', amount: 140),
];

final chartColors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.grey[100],
];
