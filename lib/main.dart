import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:officeapp/Views/StartPage.dart';
import 'package:officeapp/Views/NavBar.dart';
import 'package:officeapp/firebase_options.dart';
import 'package:officeapp/services/firebase_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'Views/Notifications.dart';
import 'Views/OnBoarding.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OfficeAPP',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<bool>(
        future: checkFirstRun(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data == true) {
            // It's the first run, show the Onboarding page.
            return const OnBoarding();
          } else {
            // Not the first run, show the Login page.
            return StartPage();
            // return NavBar();
          }
        },
      ),
      navigatorKey: navigatorKey,
      routes: {'/notifications': (context) => Notifications()},
    );
  }

  Future<bool> checkFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    final firstRun = prefs.getBool('firstRun') ?? true;

    if (firstRun) {
      // It's the first run, set the flag to false for subsequent runs.
      await prefs.setBool('firstRun', false);
    }

    return firstRun;
  }
}
