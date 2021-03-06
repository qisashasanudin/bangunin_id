import 'package:bangunin_id/screens/main_page_wrapper.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/edit_project/project_BoQ.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/edit_project/project_Review.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/edit_project/project_information.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/edit_project/project_materials.dart';
import 'package:bangunin_id/screens/mainmenu/home/projects/view_project/project_details.dart';
import 'package:bangunin_id/screens/mainmenu/shop/tab_checkout.dart';
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
          '/projectinformation': (context) => ProjectInformation(),
          '/projectBoQ': (context) => ProjectBoQ(),
          '/projectmaterials': (context) => ProjectMaterials(),
          '/projectdetails': (context) => ProjectDetails(),
          '/tabcheckout': (context) => CheckoutTab(),
          '/projectreview': (context) => ProjectReview(),
        },
      ),
    );
  }
}
