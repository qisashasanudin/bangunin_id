import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';// sumber AppColors()
import 'package:bangunin_id/shared/sliver_panel.dart';
import 'package:flutter/material.dart';

class NewProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPanel(
          children: [
            SliverAppBar(
              stretch: true,
              pinned: true,
              expandedHeight: screenHeight / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Buat Proyek Baru'),
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
              ),
            ),
            //sliver-sliver lain ditulis di sini
          ],
        );
      },
    );
  }
}
