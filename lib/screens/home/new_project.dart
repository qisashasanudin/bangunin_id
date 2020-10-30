import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class NewProject extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primary,
      appBar: AppBar(
        title: Text('Buat Proyek Baru'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          
        ],
      ),
    );
  }
}
