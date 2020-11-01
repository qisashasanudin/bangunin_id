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
              expandedHeight: screenHeight / 20,
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
            SliverPersistentHeader(
              delegate: HomeAppBar(expandedHeight: screenHeight / 3),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: RaisedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call, color: Colors.white),
                    label: Text(
                      'Bangunin.id',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.only(left: 90, right: 90),
                ),
                ListTile(title: Text('Nama'), subtitle: Text('Hanvey Xavero')),
                ListTile(
                    title: Text('Telephone Number'),
                    subtitle: Text('0818-XXXX-XXXX')),
                ListTile(
                    title: Text('ALamat'),
                    subtitle: Text(
                        'Jalan Sunter karya selatan hb 11 no 12, tanjung priuk sunter jakarta utara kecamatan pasar rebu dkk.')),
                ListTile(
                    title: Text('Email'),
                    subtitle: Text('hanveyxavero888@gmail.com')),
                ListTile(title: Text('Project Done'), subtitle: Text('2')),
                ListTile(
                    title: Text('Project in progress'), subtitle: Text('3')),
              ]),
            ),
            //Sliver-sliver lain ditulis di sini
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  HomeAppBar({@required this.expandedHeight});

  @override
  double get maxExtent => expandedHeight;
  double get minExtent => kToolbarHeight;
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        bgroundColor(context, shrinkOffset),
        coverPicture(shrinkOffset),
        coverPictureGradient(context, shrinkOffset),
        pageTitle(shrinkOffset),
        profilePicture(shrinkOffset),
      ],
    );
  }

  Container bgroundColor(BuildContext context, double shrinkOffset) {
    return Container(
      width: double.infinity,
      height: shrinkOffset,
      decoration: BoxDecoration(
        color: AppColors().primary,
      ),
    );
  }

  Opacity coverPicture(double shrinkOffset) {
    return Opacity(
      opacity: (1 - shrinkOffset / expandedHeight),
      child: Image.asset(
        'assets/img/home_bg_default2.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Opacity coverPictureGradient(BuildContext context, double shrinkOffset) {
    return Opacity(
      opacity: (1 - shrinkOffset / expandedHeight),
      child: Container(
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
      ),
    );
  }

  Positioned pageTitle(double shrinkOffset) {
    return Positioned(
      top: 30,
      child: Opacity(
        opacity: shrinkOffset / expandedHeight,
        child: Text(
          "Beranda",
          style: TextStyle(
            color: AppColors().accent1,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Positioned profilePicture(double shrinkOffset) {
    return Positioned(
      top: expandedHeight - 100 - shrinkOffset,
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: Card(
          elevation: 10,
          shape: CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.only(top: 100, left: 100),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {}),
                ),
              ),
              radius: 70,
              backgroundColor: AppColors().primary,
              backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

//Color(0xff555000)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff555000);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
