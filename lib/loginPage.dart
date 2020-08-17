import 'package:flutter/material.dart';
// import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginPage';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  String email, pass, errorMsg;
  bool isLggedIn;

  FirebaseAuth _auth = FirebaseAuth.instance;
//SignIn with email Fxn
  signIn() async {
    print('signin executed');
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: this.email, password: this.pass);
      final FirebaseUser user = result.user;
      print(user);
      if (user != null) {
        //Navigation
        makeLogin();
        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } catch (e) {
      setState(() {
        errorMsg = e.message;
      });
      errorDialog();
    }
  }

  makeLogin() async {
    SharedPreferences _login = await SharedPreferences.getInstance();
    setState(() {
      isLggedIn = true;
      print(isLggedIn);
    });
    await _login.setBool('isloged', true);
  }

  getLogininfo() async {
    SharedPreferences _login = await SharedPreferences.getInstance();
    final login = _login.getBool('isloged') ?? false;
    print("Status: $login");
  }

  makeLogout() async {
    SharedPreferences login = await SharedPreferences.getInstance();
    setState(() {
      isLggedIn = false;
    });
    await login.setBool('islog', false);
    print(login);
  }

  // LogIn Checker
  loggedInOrNot() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    try {
      if (user.email != null) {
        Navigator.pushReplacementNamed(context, HomePage.id);
        makeLogin();
      } else {
        print('not logged');
      }
    } catch (e) {
      setState(() {
        errorMsg = e.message;
      });
      errorDialog();
    }
  }

  // Error dialogbox
  errorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: Text(errorMsg),
          actions: [
            FlatButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.red, width: 2),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loggedInOrNot();
  }

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
                key: _key,
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
                          /////////////////////////////////////////////////////
                          ///===================Get-IN Button=======///////////
                          /////////////////////////////////////////////////////
                          child: RaisedButton(
                              // onLongPress: () {
                              //   noCheckLogin();
                              // },
                              onPressed: () {
                                ///Perform action
                                // makeLogin();
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  signIn();
                                }
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
                              onPressed: () async {
                                SharedPreferences _login =
                                    await SharedPreferences.getInstance();
                                final login =
                                    _login.getBool('isloged') ?? false;
                                print("Status: $login");
                              },
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
