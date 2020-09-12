import 'package:flutter/material.dart';
import 'package:mentor_digishala/authProvider.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/landingPage.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'package:mentor_digishala/policy.dart';
import 'package:mentor_digishala/signUpPage.dart';
import 'package:mentor_digishala/tabs/classChangeTab.dart';
import 'package:mentor_digishala/tabs/messeging/textingTabs.dart';
import 'package:mentor_digishala/terms.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) {
            return AuthProvider();
          },
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
