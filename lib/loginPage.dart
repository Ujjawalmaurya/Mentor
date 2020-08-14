import 'package:flutter/material.dart';
// import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginPage';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, pass;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/login.png",
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                  tag: 'logo',
                  child: CircleAvatar(
                      maxRadius: 100.0,
                      backgroundColor: Colors.deepPurpleAccent,
                      backgroundImage: AssetImage('assets/mascot.png'))),
              SizedBox(height: 90.0),
              Form(
                // key: _key,
                child: Card(
                  margin: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(0.0)),
                      ////========
                      //Username
                      ////========
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.userAlt),
                        title: TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Username is required';
                            }
                          },
                          decoration: InputDecoration(labelText: "Username"),
                          onSaved: (input) {
                            setState(() {
                              email = input;
                            });
                            print(this.email);
                          },
                        ),
                      ),
                      ////==============
                      ///Password
                      ////==============
                      ListTile(
                          leading: FaIcon(FontAwesomeIcons.lock),
                          title: TextFormField(
                              obscureText: true,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Password is required';
                                } else if (input.length < 6) {
                                  return 'Password is too short';
                                }
                              },
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              onSaved: (input) {
                                setState(() {
                                  pass = input;
                                });
                                print(this.pass);
                              })),
                      Padding(padding: EdgeInsets.all(25.0)),
                      Container(
                          height: 50.0,
                          width: 220.0,
                          child: RaisedButton(
                              onPressed: () {
                                ///Perform action
                                Navigator.pushNamed(context, HomePage.id);
                              },
                              color: Colors.redAccent,
                              splashColor: Colors.deepPurpleAccent,
                              child: Text("Get in",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontFamily: 'Pacifico')),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)))),
                      SizedBox(
                          height: 30.0,
                          child: Text('or', style: TextStyle(fontSize: 20.0))),
                      ////===========================////
                      //Sign in with Google Button
                      ////===========================////
                      Container(
                          height: 37.0,
                          width: 300.0,
                          child: RaisedButton(
                              color: Colors.purpleAccent,
                              splashColor: Colors.deepPurpleAccent,
                              child: Text("Sign-in with GOOGLE",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    // fontFamily: 'Pacifico',
                                  )),
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)))),
                      Padding(padding: EdgeInsets.all(25.0)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
