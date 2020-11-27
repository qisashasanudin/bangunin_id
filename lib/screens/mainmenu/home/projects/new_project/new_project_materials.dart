import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/shared/UI_components/custom_sliver_app_bar.dart';
import 'package:bangunin_id/shared/page_templates/sliver_page.dart';
import 'package:flutter/material.dart';

class NewProjectMaterials extends StatefulWidget {
  @override
  _NewProjectMaterialsState createState() => _NewProjectMaterialsState();
}

class _NewProjectMaterialsState extends State<NewProjectMaterials> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final userID = _auth.getCurrentUID();

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: userID).entitySnapshot('projects'),
      builder: (context, snapshot) {
        return Form(
          key: _formKey,
          child: SliverPage(
            children: [
              CustomSliverAppBar(
                // backgroundImage: Image.asset(
                //   'assets/img/sliver_page_bg.jpg',
                //   fit: BoxFit.cover,
                // ),
                title: Text('Material Proyek Baru'),
              ),
              //sliver-sliver lain ditulis di sini
            ],
          ),
        );
      },
    );
  }
}
