import 'package:flutter/material.dart';
import 'package:mentor_digishala/authProvider.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'package:provider/provider.dart';

//code used from https://medium.com/coding-with-flutter/super-simple-authentication-flow-with-flutter-firebase-737bba04924c
class LandingPage extends StatelessWidget {
  static const String id = 'LandingPage';

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    if (authProvider.isAuthenticated) {
      return HomePage();
    } else {
      return LoginScreen();
    }
  }
}
