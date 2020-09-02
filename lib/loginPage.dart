import 'package:flutter/material.dart';
// import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

        Navigator.pushReplacementNamed(context, HomePage.id);
      }
    } catch (e) {
      setState(() {
        errorMsg = e.message;
      });
      errorDialog();
    }
  }

  //Error dialogbox
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
              ]);
        });
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
      child: SafeArea(
        child: Center(
          child: Form(
            key: _key,
            child: Card(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.02)),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage('assets/loginAsset.jpg'))),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.width * 0.58,
                    ),

                    SizedBox(height: 20.0),
                    //==========
                    //Username
                    ////========
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.userAlt),
                      title: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Username is required';
                          }
                        },
                        decoration: InputDecoration(labelText: "Username"),
                        onSaved: (input) {
                          setState(() {
                            email = input + '@mentor.nca';
                          });
                          print(this.email);
                        },
                      ),
                    ),
                    ////==============
                    ///Password
                    ////==============
                    ListTile(
                        leading: FaIcon(FontAwesomeIcons.keycdn),
                        title: TextFormField(
                            obscureText: true,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Password is required';
                              } else if (input.length < 6) {
                                return 'Password is too short';
                              }
                            },
                            decoration: InputDecoration(labelText: "Password"),
                            onSaved: (input) {
                              setState(() {
                                pass = input;
                              });
                              print(this.pass);
                            })),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.02)),
                    Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width * 0.65,
                        /////////////////////////////////////////////////////
                        ///===================Get-IN Button=======///////////
                        /////////////////////////////////////////////////////
                        child: RaisedButton(
                            onPressed: () {
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
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.035)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
