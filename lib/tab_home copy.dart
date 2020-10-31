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
    final Size size = MediaQuery.of(context).size;
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
    final List<String> status = <String>[
      'In - Progress',
      'In - Progress',
      'Done',
      'In - Progress',
      'In - Progress',
      'Done'
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: transparentAppbarAndNavbar(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors().accent1,
        body: Container(
          height: size.height,
          child: Column(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: <Widget>[
                  coverPicture(context),
                  coverPictureGradient(context),
                  profilePicture(),
                ],
              ),
              SizedBox(height: 50.0),
              userInfo(),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        tileColor: AppColors().accent3,
                        title: Text('Project ${entries[index]}'),
                        trailing: Text(
                          '${status[index]}',
                          style: TextStyle(
                              color: (status[index] == 'Done'
                                  ? Colors.green
                                  : Colors.red)),
                        ),
                        onTap: () async {
                          Navigator.of(context).pushNamed('/projectdetails');
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 80.0),
            ],
          ),
        ),
        floatingActionButton: createProjectButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Image coverPicture(BuildContext context) {
    return Image(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      fit: BoxFit.cover,
      image: AssetImage('assets/img/home_bg_default1.jpg'),
    );
  }

  Container coverPictureGradient(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: AppColors().accent1,
        gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              AppColors().primary.withOpacity(0.5),
              AppColors().accent1.withOpacity(0.0),
            ],
            stops: [
              0.0,
              1.0
            ]),
      ),
    );
  }

  Positioned profilePicture() {
    return Positioned(
      bottom: -50,
      child: Card(
        elevation: 10,
        shape: CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 75,
            backgroundColor: AppColors().primary,
            backgroundImage: AssetImage('assets/img/profile_pic_default.jpg'),
          ),
        ),
      ),
    );
  }

  ListTile userInfo() {
    return ListTile(
      title: Center(
        child: Text('Pengguna baru'),
      ),
      subtitle: Center(
        child: Text('Peran belum dikonfigurasi'),
      ),
    );
  }

  FloatingActionButton createProjectButton(BuildContext context) {
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
  }
}
