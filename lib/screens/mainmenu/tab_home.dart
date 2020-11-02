import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  ScrollController _scrollController;
  double scrollPosition = 0;

  _scrollListener() {
    setState(() {
      scrollPosition = (1 - _scrollController.position.pixels);
    });
  }

  void loadScrollPos() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    scrollPosition = pref.getDouble('scrollPosition');
  }

  void saveScrollPos(double data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble('scrollPosition', data);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    print(scrollPosition);
    loadScrollPos();
    print(scrollPosition);
    super.initState();
  }

  @override
  void dispose() {
    saveScrollPos(scrollPosition);
    _scrollController.dispose();
    super.dispose();
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
                  child: SizedBox(height: 120),
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
          userInfo(screenHeight, userID),
        ],
      ),
    );
  }

  FlexibleSpaceBar homeAppBar(double screenHeight) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Opacity(
        opacity: 1 - scrollFadeCalculator(screenHeight / 5),
        child: Text('Beranda'),
      ),
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
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/home_bg_default1.jpg',
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

  StreamBuilder userInfo(double screenHeight, String userID) {
    return StreamBuilder(
      stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingText();
        } else {
          return Positioned(
            top: (scrollPosition ?? 0) + screenHeight / 5,
            child: Opacity(
              opacity: scrollFadeCalculator(screenHeight / 5),
              child: Column(
                children: [
                  profilePicture(),
                  SizedBox(height: 10.0),
                  displayName(snapshot),
                  displayUserType(snapshot),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Card profilePicture() {
    return Card(
      elevation: 10,
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          radius: 60,
          backgroundColor: AppColors().primary,
          backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
        ),
      ),
    );
  }

  Text displayName(AsyncSnapshot snapshot) {
    return Text(snapshot.data.data['name'],
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold));
  }

  Text displayUserType(AsyncSnapshot snapshot) {
    return (snapshot.data.data['isSupervisor'])
        ? Text('Mandor', style: TextStyle(fontSize: 15))
        : Text('Konsumen', style: TextStyle(fontSize: 15));
  }

  double scrollFadeCalculator(double h) {
    return ((((scrollPosition ?? 0) + h) / h <= 0)
        ? 0
        : (((scrollPosition ?? 0) + h) / h >= 1)
            ? 1
            : ((scrollPosition ?? 0) + h) / h);
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
