import 'package:bangunin_id/models/material_model.dart';
import 'package:flutter/material.dart';

import 'Item_card.dart';

class CategoryC extends StatelessWidget {
  //========================= main function =========================
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: materialsDataset.length,
        itemBuilder: (context, int index) {
          return ItemCard(item: materialsDataset[index], index: index);
        },
      ),
    );
  }
  //========================= main function =========================
}
