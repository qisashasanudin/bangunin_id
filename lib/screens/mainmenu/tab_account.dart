import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:flutter/services.dart';

class Account extends StatelessWidget {
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
          slivers: [
            SliverAppBar(
              expandedHeight: screenHeight / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Akun'),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.logout, color: AppColors().accent1),
                  label: Text('Keluar',
                      style: TextStyle(color: AppColors().accent1)),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                )
              ],
            ),
            //Sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );

    Padding _profileText() {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 35.0,
            letterSpacing: 1.5,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    Container _circleAvatar(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('img/profile_pic_default3.jpg'),
          ),
        ),
      );
    }
  }
}
