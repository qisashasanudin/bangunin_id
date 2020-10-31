import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: HomeSliverAppBar(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  title: Text("Index: $index"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeSliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeSliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/img/home_bg_default1.jpg',
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "Proyek",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              shape: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: AppColors().primary,
                  backgroundImage:
                      AssetImage('assets/img/profile_pic_default.jpg'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
