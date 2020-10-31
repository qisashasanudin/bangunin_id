import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:flutter/services.dart';

class Account extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: AppColors().accent1,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
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
  }
}
