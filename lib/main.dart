import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happy/screens/createOrphanage.dart';
import 'package:happy/screens/createOrphanageOne.dart';
import 'package:happy/screens/home.dart';
import 'package:happy/screens/onboard-one.dart';
import 'package:happy/screens/onboard-two.dart';
import 'package:happy/screens/splash.dart';
import 'package:happy/utils/routes.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orphanages',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Nunito-SemiBold',
      ),
      home: Splash(),
      routes: {
        AppRoutes.SPLASH: (ctx) => Splash(),
        AppRoutes.ONBORARD_ONE: (ctx) => OnboardOne(),
        AppRoutes.ONBORARD_TWO: (ctx) => OnboardTwo(),
        AppRoutes.HOME: (ctx) => Home(),
        AppRoutes.CREATE_ORPHANAGE: (ctx) => CreateOrphanage(),
        AppRoutes.CREATE_ORPHANAGE_ONE: (ctx) => CreateOrphanageOne(),
      },
    );
  }
}
