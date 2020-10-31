import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'A',
    'B',
    'C',
  ];
  final List<String> status = <String>[
    'In - Progress',
    'In - Progress',
    'Done',
    'In - Progress',
    'In - Progress',
    'Done',
    'In - Progress',
    'In - Progress',
    'Done'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Proyek'),
                centerTitle: true,
                background: Image.asset(
                  'assets/img/home_bg_default1.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Column(
            children: <Widget>[
              //profilePicture(),
              SizedBox(height: 20.0),
              userInfo(),
              SizedBox(height: 20.0),
              projectList(),
              SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
      floatingActionButton: createProjectButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Card profilePicture() {
    return Card(
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

  Expanded projectList() {
    return Expanded(
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
                    color:
                        (status[index] == 'Done' ? Colors.green : Colors.red)),
              ),
              onTap: () async {
                Navigator.of(context).pushNamed('/projectdetails');
              },
            ),
          );
        },
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
