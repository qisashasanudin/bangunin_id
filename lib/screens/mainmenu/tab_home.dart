import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().accent1,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: HomeAppBar(expandedHeight: 250),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 40.0),
          ),
          SliverToBoxAdapter(
            child: userInfo(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
          ),
          SliverList(
            delegate: infiniteList(),
          )
        ],
      ),
      floatingActionButton: createProjectButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container userInfo() {
    return Container(
      child: ListTile(
        title: Center(
          child: Text('Pengguna baru'),
        ),
        subtitle: Center(
          child: Text('Peran belum dikonfigurasi'),
        ),
      ),
    );
  }

  FloatingActionButton createProjectButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        Navigator.of(context).pushNamed('/newproject');
      },
      label: Text(
        'Buat Proyek Baru',
        style: TextStyle(color: AppColors().accent1),
      ),
      backgroundColor: AppColors().primary,
    );
  }
}

SliverChildBuilderDelegate infiniteList() {
  return SliverChildBuilderDelegate(
    (_, index) => ListTile(
      title: Text("Index: $index"),
    ),
  );
}

class HomeAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeAppBar({@required this.expandedHeight});

  @override
  double get maxExtent => expandedHeight;
  double get minExtent => kToolbarHeight;
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        bgroundColor(context),
        coverPicture(shrinkOffset),
        coverPictureGradient(context, shrinkOffset),
        pageTitle(shrinkOffset),
        profilePicture(shrinkOffset),
      ],
    );
  }

  Container bgroundColor(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: AppColors().primary,
      ),
    );
  }

  Opacity coverPicture(double shrinkOffset) {
    return Opacity(
      opacity: (1 - shrinkOffset / expandedHeight),
      child: Image.asset(
        'assets/img/home_bg_default1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Opacity coverPictureGradient(BuildContext context, double shrinkOffset) {
    return Opacity(
      opacity: (1 - shrinkOffset / expandedHeight),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                AppColors().primary.withOpacity(0.5),
                AppColors().accent1.withOpacity(0.0),
              ],
              stops: [
                0.0,
                1.0
              ]),
        ),
      ),
    );
  }

  Center pageTitle(double shrinkOffset) {
    return Center(
      child: Opacity(
        opacity: shrinkOffset / expandedHeight,
        child: Text(
          "Proyek",
          style: TextStyle(
            color: AppColors().accent1,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Positioned profilePicture(double shrinkOffset) {
    return Positioned(
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
              backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
