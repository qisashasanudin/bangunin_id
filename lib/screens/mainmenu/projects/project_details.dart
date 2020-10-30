import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primary,
      appBar: AppBar(
        title: Text('Rincian Proyek'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          
        ],
      ),
    );
  }
}
