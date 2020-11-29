import 'package:bangunin_id/screens/main_page_wrapper.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/new_project/new_project_information.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/new_project/new_project_materials.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/view_project/project_details.dart';
import 'package:bangunin_id/screens/mainmenu/account/tab_account.dart';
import 'package:bangunin_id/screens/mainmenu/home/tab_home.dart';
import 'package:bangunin_id/screens/mainmenu/shop/tab_shop.dart';
import 'package:bangunin_id/screens/mainmenu/settings/tab_settings.dart';
import 'package:bangunin_id/services/database.dart';
import 'package:bangunin_id/models/project_details_model.dart';
import 'package:bangunin_id/models/account_model.dart';
import 'package:bangunin_id/shared/UI_components/loading_screen.dart';
import 'package:bangunin_id/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bangunin_id/services/auth.dart';
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
        StreamProvider<List<AccountModel>>.value(
          value: DatabaseService().accounts,
        ),
        StreamProvider<List<ProjectDetailsModel>>.value(
          value: DatabaseService().myProjects,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bangunin.id',
        theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          primarySwatch: Colors.amber,
          //fontFamily: 'Georgia',
        ),
        initialRoute: '/splashscreen',
        routes: {
          '/splashscreen': (context) => SplashScreen(),
          '/loadingscreen': (context) => LoadingScreen(),
          '/mainpage': (context) => MainPageWrapper(),
          '/home': (context) => HomeTab(),
          '/buy': (context) => ShopTab(),
          '/account': (context) => AccountTab(),
          '/settings': (context) => SettingsTab(),
          '/newprojectinformation': (context) => NewProjectInformation(),
          '/newprojectmaterials': (context) => NewProjectMaterials(),
          '/projectdetails': (context) => ProjectDetails(),
        },
      ),
    );
  }
}
