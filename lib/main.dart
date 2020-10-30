import 'package:bangunin_id/screens/main_page_wrapper.dart';
import 'package:bangunin_id/screens/mainmenu/projects/new_project.dart';
import 'package:bangunin_id/screens/mainmenu/projects/project_details.dart';
import 'package:bangunin_id/screens/mainmenu/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/tab_settings.dart';
import 'package:bangunin_id/screens/transitions/splashscreen.dart';
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
          '/mainpage': (context) => MainPageWrapper(),
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
