import 'package:bangunin_id/models/material_model.dart';
import 'package:flutter/material.dart';

import 'Item_card.dart';

class CategoryA extends StatelessWidget {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: materials.length,
        itemBuilder: (context, int index) {
          return ItemCard(item: materials[index], index: index);
        },
      ),
    );
  }
  //========================= main function =========================
}
