import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/sliver_page.dart';
import 'package:flutter/material.dart';

class NewProjectMaterials extends StatefulWidget {
  @override
  _NewProjectMaterialsState createState() => _NewProjectMaterialsState();
}

class _NewProjectMaterialsState extends State<NewProjectMaterials> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return Form(
          key: _formKey,
          child: SliverPage(
            children: [
              SliverAppBar(
                stretch: true,
                pinned: true,
                expandedHeight: screenHeight / 4,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Material Untuk Proyek'),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                  ],
                ),
              ),
              //sliver-sliver lain ditulis di sini
            ],
          ),
        );
      },
    );
  }
}
