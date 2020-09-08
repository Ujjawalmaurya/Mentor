import 'package:flutter/material.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/landingPage.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'package:mentor_digishala/signUpPage.dart';
import 'package:mentor_digishala/tabs/classChangeTab.dart';
import 'package:mentor_digishala/tabs/messeging/textingTabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LandingPage.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),
        LandingPage.id: (context) => LandingPage(),
        "signup": (context) => SignUpPage(),
        TextingTabs.id: (context) => TextingTabs(),
        ClassChangeTab.id: (context) => ClassChangeTab(),
      },
      title: "Mentor -DigiShala",
      theme: ThemeData.light(),
      // home: LoginScreen(),
    );
  }
}
