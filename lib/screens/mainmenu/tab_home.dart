import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors().accent1,
        appBar: profileAppBar(),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    coverPicture(context),
                    coverPictureGradient(context),
                    profilePicture(),
                  ],
                ),
                SizedBox(height: 50.0),
                userInfo(),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        floatingActionButton: createProjectButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  AppBar profileAppBar() {
    return AppBar(
      title: Text('Profile'),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      actions: <Widget>[],
    );
  }

  Image coverPicture(BuildContext context) {
    return Image(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.cover,
      image: AssetImage('assets/img/home_bg_default2.jpg'),
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
              AppColors().accent2.withOpacity(0.7),
              AppColors().accent1.withOpacity(0.0),
            ],
            stops: [
              0.0,
              0.5
            ]),
      ),
    );
  }

  Positioned profilePicture() {
    return Positioned(
      bottom: -50,
      child: Card(
        elevation: 2,
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
    );
  }

  ListTile userInfo() {
    return ListTile(
      title: Center(
        child: Text('Pengguna baru'),
      ),
      subtitle: Center(
        child: Text('Peran belum dikonfigurai'),
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
