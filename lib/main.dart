import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/screens/homepage_wrapper.dart';
import 'package:bangunin_id/screens/home/new_project.dart';
import 'package:bangunin_id/screens/home/project_details.dart';
import 'package:bangunin_id/screens/home/account_settings.dart';
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
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomepageWrapper(),
          '/newproject': (context) => NewProject(),
          '/projectdetails': (context) => ProjectDetails(),
          '/account': (context) => AccountSettings(),
        },
      ),
    );
  }
}
