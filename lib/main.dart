import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/screen_wrapper.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreenWrapper(),
      ),
    );
  }
}
