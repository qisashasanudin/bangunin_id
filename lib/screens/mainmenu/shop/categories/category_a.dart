import 'package:bangunin_id/models/items_model.dart';
import 'package:flutter/material.dart';

import 'Item_card.dart';

class CategoryA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, int key) {
          return ItemCard(index: key);
        },
      ),
    );
  }
}
