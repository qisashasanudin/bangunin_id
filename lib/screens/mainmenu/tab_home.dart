import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  double scrollPosition;

  _scrollListener() {
    setState(() {
      scrollPosition = (1 - _scrollController.position.pixels);
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final userID = Provider.of<User>(context).uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Scaffold(
            backgroundColor: AppColors().accent1,
            body: CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  pinned: true,
                  expandedHeight: screenHeight / 4,
                  flexibleSpace: homeAppBar(screenHeight),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 70.0),
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
            floatingActionButton:
                createProjectButton(userID), // hanya untuk mandor
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          ),
          profilePicture(screenHeight),
        ],
      ),
    );
  }

  FlexibleSpaceBar homeAppBar(double screenHeight) {
    return FlexibleSpaceBar(
      background: Container(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            coverPicture(),
            coverPictureGradient(),
          ],
        ),
      ),
      centerTitle: true,
      title: Opacity(
        opacity: 1 - scrollFade(screenHeight / 5),
        child: Text('Beranda'),
      ),
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/home_bg_default2.jpg',
      fit: BoxFit.cover,
    );
  }

  Container coverPictureGradient() {
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

  Positioned profilePicture(double screenHeight) {
    return Positioned(
      top: (scrollPosition ?? 0) + screenHeight / 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: scrollFade(screenHeight / 5),
            child: Card(
              elevation: 10,
              shape: CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: screenHeight / 10,
                  backgroundColor: AppColors().primary,
                  backgroundImage:
                      AssetImage('assets/img/profile_pic_default.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double scrollFade(double h) {
    return ((((scrollPosition ?? 0) + h) / h <= 0)
        ? 0
        : (((scrollPosition ?? 0) + h) / h >= 1)
            ? 1
            : ((scrollPosition ?? 0) + h) / h);
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
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              subtitle: Center(
                child: (snapshot.data.data['isSupervisor'])
                    ? Text('Mandor',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))
                    : Text('Konsumen',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
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
}
