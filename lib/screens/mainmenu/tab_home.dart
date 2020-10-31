import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: HomeAppBar(expandedHeight: 200),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 60.0),
          ),
          SliverToBoxAdapter(
            child: userInfo(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.0),
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

class HomeAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        coverPicture(),
        coverPictureGradient(context),
        pageTitle(shrinkOffset),
        profilePicture(shrinkOffset),
      ],
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/home_bg_default1.jpg',
      fit: BoxFit.cover,
    );
  }

  Container coverPictureGradient(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: AppColors().accent1,
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
    );
  }

  Center pageTitle(double shrinkOffset) {
    return Center(
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

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
