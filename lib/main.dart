import 'package:bangunin_id/screens/home/projects/new_project.dart';
import 'package:bangunin_id/screens/home/projects/project_details.dart';
import 'package:bangunin_id/screens/home/tab_account.dart';
import 'package:bangunin_id/screens/home/tab_home.dart';
import 'package:bangunin_id/screens/home/tab_settings.dart';
import 'package:bangunin_id/screens/main_menu_wrapper.dart';
import 'package:bangunin_id/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/models/user.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart';
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
        title: 'Bangunin.id',
        theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          primaryColor: AppColors().primary,
          accentColor: AppColors().accent1,
          //fontFamily: 'Georgia',
        ),
        initialRoute: '/splashscreen',
        routes: {
          '/splashscreen': (context) => SplashScreen(),
          '/mainmenu': (context) => MainMenuWrapper(),
          '/home': (context) => Home(),
          '/account': (context) => Account(),
          '/settings': (context) => Settings(),
          '/newproject': (context) => NewProject(),
          '/projectdetails': (context) => ProjectDetails(),
        },
      ),
    );
  }
}
