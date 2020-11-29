import 'package:bangunin_id/screens/mainmenu/account/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/home/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/shop/tab_shop.dart';
import 'package:bangunin_id/screens/mainmenu/settings/tab_settings.dart';
import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:bangunin_id/shared/UI_components/loading_text.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/transparent_appbar_and_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenuTabNav extends StatefulWidget {
  @override
  _MainMenuTabNavState createState() => _MainMenuTabNavState();
}

class _MainMenuTabNavState extends State<MainMenuTabNav> {
  final PageStorageBucket bucket = PageStorageBucket();
  final userID = AuthService().getCurrentUID();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.renderView.automaticSystemUiAdjustment = false;
    SystemChrome.setSystemUIOverlayStyle(
      transparentAppbarAndNavbar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
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
              navigationTab(),
            ],
          ),
        ),
      ),
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/UI/home_bg_default3.jpg',
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
            Theme.of(context).primaryColor,
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
        stream: DatabaseService(uid: userID).entityDocumentSnapshot('accounts'),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Ada kesalahan, silahkan coba lagi.');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingText();
          }
          return new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              profilePicture(snapshot),
              profileTexts(snapshot),
            ],
          );
        },
      ),
    );
  }

  Card profilePicture(snapshot) {
    return Card(
      elevation: 10,
      shape: CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors().accent1,
          backgroundImage: (snapshot.data.data()['profilePicture'] != null)
              ? NetworkImage(snapshot.data.data()['profilePicture'])
              : AssetImage('assets/img/UI/profile_pic_default.jpg'),
        ),
      ),
    );
  }

  Padding profileTexts(AsyncSnapshot snapshot) {
    return new Padding(
      padding: const EdgeInsets.all(15.0),
      child: new Column(
        children: <Widget>[
          new Text(
            snapshot.data.data()['name'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors().accent1,
            ),
          ),
          new SizedBox(height: 5),
          new Text(
            snapshot.data.data()['role'],
            style: TextStyle(
              fontSize: 15,
              color: AppColors().accent1,
            ),
          ),
        ],
      ),
    );
  }

  Scaffold navigationTab() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageStorage(
        bucket: bucket,
        child: TabBarView(
          children: <Widget>[
            HomeTab(/*key: PageStorageKey('Beranda'),*/),
            ShopTab(/*key: PageStorageKey('Beli'),*/),
            AccountTab(/*key: PageStorageKey('Akun')*/),
            SettingsTab(/*key: PageStorageKey('Pengaturan'),*/),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors().accent1,
        child: TabBar(
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.shopping_cart)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.settings)),
          ],
          labelColor: Theme.of(context).primaryColor,
          indicator: UnderlineTabIndicator(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 4.0),
            insets: EdgeInsets.only(bottom: 44),
          ),
          unselectedLabelColor: AppColors().accent3,
        ),
      ),
    );
  }
}
