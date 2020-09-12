import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/landingPage.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'package:mentor_digishala/policy.dart';
import 'package:mentor_digishala/signUpPage.dart';
import 'package:mentor_digishala/tabs/classChangeTab.dart';
import 'package:mentor_digishala/tabs/messeging/textingTabs.dart';
import 'package:mentor_digishala/terms.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return MaterialApp(
      initialRoute: LandingPage.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),
        LandingPage.id: (context) => LandingPage(),
        "signup": (context) => SignUpPage(),
        TextingTabs.id: (context) => TextingTabs(),
        ClassChangeTab.id: (context) => ClassChangeTab(),
        Policy.id: (context) => Policy(),
        TermsnC.id: (context) => TermsnC(),
      },
      title: "Mentor -DigiShala",
      theme: ThemeData.light(),
      // home: LoginScreen(),
    );
    ;
  }
}
