import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/mainmenu/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/tab_settings.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainMenuTabNav extends StatefulWidget {
  @override
  _MainMenuTabNavState createState() => _MainMenuTabNavState();
}

class _MainMenuTabNavState extends State<MainMenuTabNav> {
  final PageStorageBucket bucket = PageStorageBucket();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<User>(context).uid;

    return DefaultTabController(
      length: 3,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().primary,
        ),
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: <Widget>[
              coverPicture(),
              coverPictureGradient(),
              userInfo(context, userID),
              navigation(),
            ],
          ),
        ),
      ),
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/home_bg_default3.jpg',
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
          stops: [0.0, 0.7],
        ),
      ),
    );
  }

  Positioned userInfo(context, userID) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 14,
      child: StreamBuilder(
        stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingText();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                profilePicture(),
                profileTexts(snapshot),
              ],
            );
          }
        },
      ),
    );
  }

  Card profilePicture() {
    return Card(
      elevation: 10,
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors().primary,
          backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
        ),
      ),
    );
  }

  Padding profileTexts(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            snapshot.data.data['name'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors().accent1,
            ),
          ),
          SizedBox(height: 5),
          Text(
            snapshot.data.data['role'],
            style: TextStyle(
              fontSize: 15,
              color: AppColors().accent1,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold navigation() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageStorage(
        bucket: bucket,
        child: TabBarView(
          children: <Widget>[
            Home(/*key: PageStorageKey('Beranda'),*/),
            Account(/*key: PageStorageKey('Akun')*/),
            Settings(/*key: PageStorageKey('Pengaturan'),*/),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors().accent1,
        child: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.settings)),
          ],
          labelColor: AppColors().primary,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors().primary, width: 4.0),
            insets: EdgeInsets.only(bottom: 44),
          ),
          unselectedLabelColor: AppColors().accent3,
        ),
      ),
    );
  }

  void signOut() async {
    await _auth.signOut();
  }
}
