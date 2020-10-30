import 'package:bangunin_id/shared/decorations.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().primary,
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person, color: AppColors().accent1),
                label:
                    Text('Akun', style: TextStyle(color: AppColors().accent1)),
                onPressed: () async {
                  Navigator.of(context).pushNamed('/account');
                },
              ),
              SizedBox(height: 20.0),
              SizedBox(
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
            ],
          ),
        ),
      ),
    );
  }
}
