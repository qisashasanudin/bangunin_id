import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool searchButton;
  final bool sortButton;
  final bool cartButton;
  final Function() onTapSearchButton;
  final Function() onTapSortButton;
  final Function() onTapCartButton;

  const CustomAppBar({
    Key key,
    @required this.title,
    this.searchButton,
    this.sortButton,
    this.cartButton,
    this.onTapSearchButton,
    this.onTapSortButton,
    this.onTapCartButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(title, style: TextStyle(color: AppColors().accent2)),
      actions: <Widget>[
        if (searchButton == true)
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey),
            onPressed: () async {
              onTapSearchButton();
            },
          ),
        if (sortButton == true)
          IconButton(
            icon: Icon(Icons.sort, color: Colors.grey),
            onPressed: () async {
              onTapSortButton();
            },
          ),
        if (cartButton == true)
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.grey),
            onPressed: () async {
              onTapCartButton();
            },
          ),
      ],
    );
  }
}
