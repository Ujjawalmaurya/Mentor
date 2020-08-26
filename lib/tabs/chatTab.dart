import 'package:flutter/material.dart';
import 'package:mentor_digishala/loginPage.dart';
// import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class chatTab extends StatefulWidget {
  @override
  _chatTabState createState() => _chatTabState();
}

class _chatTabState extends State<chatTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        },
        child: Text('logout'),
      ),
    );
  }
}
