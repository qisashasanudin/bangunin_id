import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  //Home({Key key}) : super(key: key);
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final userID = Provider.of<User>(context).uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                padding: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: AppColors().accent1,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.0)],
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: pullDownMarker(),
                    ),
                    SliverList(
                      delegate: accountDetails(),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Center pullDownMarker() {
  return Center(
    child: Container(
      height: 8,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors().accent3,
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );
}

SliverChildListDelegate accountDetails() {
  return SliverChildListDelegate([
    ListTile(
      title: Text('Foto Profil'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      title: Text('Nama'),
      subtitle: Text('Hanvey Xavero'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      title: Text('Email'),
      subtitle: Text('hanveyxavero888@gmail.com'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      title: Text('Password'),
      subtitle: Text('**********'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      title: Text('Telephone Number'),
      subtitle: Text('0818-XXXX-XXXX'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),
    ListTile(
      title: Text('Alamat'),
      subtitle: Text(
          'Jalan Sunter karya selatan hb 11 no 12, tanjung priuk sunter jakarta utara kecamatan pasar rebu dkk.'),
      trailing: Icon(Icons.edit),
      onTap: () {},
    ),

  ]);
}