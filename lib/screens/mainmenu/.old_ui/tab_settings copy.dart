import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  //Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              stretch: true,
              pinned: true,
              expandedHeight: screenHeight / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Pengaturan'),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
              ),
              actions: <Widget>[
                exitButton(),
              ],
            ),
            //Sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }

  FlatButton exitButton() {
    return FlatButton.icon(
      icon: Icon(Icons.logout, color: AppColors().accent1),
      label: Text('Keluar', style: TextStyle(color: AppColors().accent1)),
      onPressed: signOut,
    );
  }

  void signOut() async {
    await _auth.signOut();
  }
}
