import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/slide_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/services/auth.dart';

class BuyTab extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _BuyTabState createState() => _BuyTabState();
}

class _BuyTabState extends State<BuyTab> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return SlideUpPanel(
      children: [
        SliverToBoxAdapter(
          child: pullDownMarker(),
        ),
        // sliver-sliver lain dimasukkan di sini
      ],
      floatingButton: createProjectButton(userID),
    );
  }
}

StreamBuilder createProjectButton(String userID) {
  return StreamBuilder(
    stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
    builder: (context, snapshot) {
      if (snapshot.hasData &&
          ((snapshot.data.data()['role'] == 'Administrator') ||
              (snapshot.data.data()['role'] == 'Mandor'))) {
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
