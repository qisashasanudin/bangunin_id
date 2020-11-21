import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/decorations.dart';
import 'package:bangunin_id/shared/sliver_page.dart';
import 'package:flutter/material.dart';

class CreateNewProject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return SliverPage(
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
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, right: 15.0, left: 15.0),
                child: TextFormField(
                  decoration:
                      inputBoxBorder().copyWith(hintText: "Nama Project"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: TextFormField(
                  decoration: inputBoxBorder().copyWith(hintText: "Pasir"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: TextFormField(
                  decoration: inputBoxBorder().copyWith(hintText: "Keramik"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: TextFormField(
                  decoration: inputBoxBorder().copyWith(hintText: "Batu Bata"),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: TextFormField(
                  decoration: inputBoxBorder().copyWith(hintText: "Semen"),
                ),
              ),
            ])), //sliver-sliver lain ditulis di sini
          ],
        );
      },
    );
  }
}
