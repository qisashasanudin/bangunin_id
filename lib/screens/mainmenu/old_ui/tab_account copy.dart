import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  //Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final userID = Provider.of<User>(context).uid;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar()
          .copyWith(statusBarIconBrightness: Brightness.light),
      child: StreamBuilder<Object>(
        stream: DatabaseService(uid: userID).entitySnapshot('accounts'),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: AppColors().accent1,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  pinned: true,
                  expandedHeight: screenHeight / 4,
                  flexibleSpace: accountAppBar(screenHeight),
                ),
                SliverList(
                  delegate: accountDetails(),
                ),
                //Sliver-sliver lain ditulis di sini
              ],
            ),
          );
        },
      ),
    );
  }

  FlexibleSpaceBar accountAppBar(double screenHeight) {
    return FlexibleSpaceBar(
      background: Container(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            coverPicture(),
            coverPictureGradient(),
            profilePictureEdit(),
          ],
        ),
      ),
      centerTitle: true,
      title: Text('Akun'),
      stretchModes: [
        StretchMode.zoomBackground,
        StretchMode.fadeTitle,
      ],
    );
  }

  Image coverPicture() {
    return Image.asset(
      'assets/img/home_bg_default2.jpg',
      fit: BoxFit.cover,
    );
  }

  Container coverPictureGradient() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            AppColors().primary,
            AppColors().accent1.withOpacity(0.0),
          ],
          stops: [0.0, 0.5],
        ),
      ),
    );
  }

  Center profilePictureEdit() {
    return Center(
      child: Card(
        elevation: 10,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 60,
            backgroundColor: AppColors().primary,
            backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
            child: Padding(
              padding: EdgeInsets.only(top: 80, left: 80),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors().accent2.withOpacity(0.5),
                child: IconButton(
                    icon: Icon(Icons.edit),
                    color: AppColors().accent1,
                    onPressed: () {}),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverChildListDelegate accountDetails() {
    return SliverChildListDelegate([
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
}
