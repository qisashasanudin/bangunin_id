import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  //Home({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: DraggableScrollableSheet(
        initialChildSize: (MediaQuery.of(context).orientation == Orientation.portrait)
                ? 0.65
                : 0.3,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: scrollMenuDecoration(),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [pullDownMarker(), signOutButton()],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration scrollMenuDecoration() {
    return BoxDecoration(
      color: AppColors().accent1,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
    );
  }

  SliverToBoxAdapter pullDownMarker() {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          height: 8,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors().accent3,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  SliverList signOutButton() {
    return SliverList(
      delegate: SliverChildListDelegate([
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Keluar'),
          onTap: signOut,
        ),
      ]),
    );
  }

  void signOut() async {
    await _auth.signOut();
  }
}
