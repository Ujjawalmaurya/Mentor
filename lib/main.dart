import 'package:flutter/material.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage()
      },
      title: "Mentor -DigiShala",
      theme: ThemeData.light(),
      // home: LoginScreen(),
    );
  }
}
