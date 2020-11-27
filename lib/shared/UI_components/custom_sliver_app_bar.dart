import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key key,
    this.backgroundImage,
    this.title,
  }) : super(key: key);

  final Image backgroundImage;
  final Text title;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      elevation: 0,
      stretch: true,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: screenHeight / 3,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(left: 30, bottom: 40),
            background: backgroundImage,
            title: title,
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
          Positioned(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: AppColors().accent1,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
            ),
            bottom: -1,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }
}
