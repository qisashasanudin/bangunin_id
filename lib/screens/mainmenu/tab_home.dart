import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors().accent1,
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[],
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/img/home_bg_default2.jpg'),
                    ),
                    CoverImageGradient(),
                    Positioned(
                      bottom: -50,
                      child: Card(
                        elevation: 2,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: AppColors().primary,
                            backgroundImage: AssetImage(
                                'assets/img/profile_pic_default.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                ListTile(
                  title: Center(
                    child: Text('Pengguna baru'),
                  ),
                  subtitle: Center(
                    child: Text('Peran belum dikonfigurai'),
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: AppColors().primary,
                      child: Text(
                        'Buat Proyek Baru',
                        style: TextStyle(color: AppColors().accent1),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushNamed('/newproject');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
