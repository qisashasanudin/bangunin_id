import 'package:bangunin_id/screens/main_page_wrapper.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/new_project.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/project_details.dart';
import 'package:bangunin_id/screens/mainmenu/account/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/home/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/buy/tab_buy.dart';
import 'package:bangunin_id/screens/mainmenu/settings/tab_settings.dart';
import 'package:bangunin_id/screens/transitions/loading.dart';
import 'package:bangunin_id/screens/transitions/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
import 'package:bangunin_id/shared/decorations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
      ],
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
          '/loadingscreen': (context) => LoadingScreen(),
          '/mainpage': (context) => MainPageWrapper(),
          '/home': (context) => HomeTab(),
          '/buy': (context) => BuyTab(),
          '/account': (context) => AccountTab(),
          '/settings': (context) => SettingsTab(),
          '/newproject': (context) => NewProject(),
          '/projectdetails': (context) => ProjectDetails(),
        },
      ),
    );
  }
}
