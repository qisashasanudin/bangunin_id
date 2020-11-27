import 'package:bangunin_id/models/items_model.dart';
import 'package:flutter/material.dart';

import 'Item_card.dart';

class CategoryA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: menu.length,
        itemBuilder: (context, int index) {
          return ItemCard(index: index);
        },
      ),
    );
  }
}