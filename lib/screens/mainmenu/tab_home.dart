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
            child: SizedBox(height: 10.0),
          ),
          SliverList(
            delegate: infiniteList(context),
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

SliverChildBuilderDelegate infiniteList(BuildContext context) {
  return SliverChildBuilderDelegate(
    (BuildContext context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors().accent3,
            borderRadius: BorderRadius.circular(100),
          ),
          child: ListTile(
            dense: true,
            title: Text("Proyek $index"),
            subtitle: Text("Deadline: -"),
            trailing: Text(
              "In - progress",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              Navigator.of(context).pushNamed('/projectdetails');
            },
          ),
        ),
      );
    },
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
        coverPictureGradient(context),
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

  Container coverPictureGradient(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            AppColors().primary,
            AppColors().accent1.withOpacity(0.0),
          ],
          stops: [0.0, 0.5],
        ),
      ),
    );
  }

  Positioned pageTitle(double shrinkOffset) {
    return Positioned(
      top: 30.0,
      child: Opacity(
        opacity: shrinkOffset / expandedHeight,
        child: Text(
          "Beranda",
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
              radius: 70,
              backgroundColor: AppColors().primary,
              backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
