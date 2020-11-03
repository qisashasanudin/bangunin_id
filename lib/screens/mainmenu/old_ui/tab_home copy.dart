import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final userID = Provider.of<User>(context).uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          
          slivers: [
            SliverPersistentHeader(
              delegate: HomeAppBar(expandedHeight: screenHeight / 3),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 60.0),
            ),
            SliverToBoxAdapter(
              child: userInfo(userID),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.0),
            ),
            SliverList(
              delegate: infiniteList(context),
            )
          ],
        ),
        floatingActionButton: createProjectButton(userID), // hanya untuk mandor
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
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
        bgroundColor(context, shrinkOffset),
        coverPicture(shrinkOffset),
        coverPictureGradient(context, shrinkOffset),
        pageTitle(shrinkOffset),
        profilePicture(shrinkOffset),
      ],
    );
  }

  Container bgroundColor(BuildContext context, double shrinkOffset) {
    return Container(
      width: double.infinity,
      height: shrinkOffset,
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
      ),
    );
  }

  Positioned pageTitle(double shrinkOffset) {
    return Positioned(
      top: 30,
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
      top: expandedHeight - 100 - shrinkOffset,
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

StreamBuilder userInfo(String userID) {
  return StreamBuilder(
    stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return LoadingText();
      } else {
        return Container(
          child: ListTile(
            title: Center(
                child: Text(snapshot.data.data['name'],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            subtitle: Center(
              child: (snapshot.data.data['isSupervisor'])
                  ? Text('Mandor',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                  : Text('Konsumen',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      }
    },
  );
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

StreamBuilder createProjectButton(String userID) {
  return StreamBuilder(
    stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
    builder: (context, snapshot) {
      if (snapshot.hasData && snapshot.data.data['isSupervisor']) {
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
      } else {
        return Container();
      }
    },
  );
}