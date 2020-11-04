import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/shared/decorations.dart'; // sumber AppColors()
import 'package:bangunin_id/shared/scrollmenu.dart';
import 'package:flutter/material.dart';
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

    return ScrollMenu(
      children: [
        SliverToBoxAdapter(
          child: pullDownMarker(),
        ),
        SliverList(
          delegate: accountDetails(),
        )
      ],
    );
  }
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
