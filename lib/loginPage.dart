import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentor_digishala/constants.dart';
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
  String isLoading = 'false';

  FirebaseAuth _auth = FirebaseAuth.instance;
//SignIn with email Fxn
  signIn() async {
    setState(() {
      isLoading = 'true';
    });
    print('signin executed');
    try {
      AuthResult result = await _auth
          .signInWithEmailAndPassword(email: this.email, password: this.pass)
          .whenComplete(() {
        setState(() {
          isLoading = 'false';
        });
      });
      final FirebaseUser user = result.user;
      print(user);
      if (user != null) {
        //Navigation

        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.id, (route) => false);
      }
    } catch (e) {
      setState(() {
        errorMsg = e.message;
        isLoading = 'false';
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
    return isLoading == 'true'
        ? Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
            color: Color(0xff3C40C6),
            child: SpinKitWanderingCubes(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
          )
        : Container(
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
                    elevation: 25.0,
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06,
                        right: MediaQuery.of(context).size.width * 0.06,
                        top: MediaQuery.of(context).size.height * 0.08,
                        bottom: MediaQuery.of(context).size.height * 0.17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/loginAsset.jpg'))),
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.width * 0.55,
                          ),

                          SizedBox(height: 10.0),
                          //==========
                          //Username
                          ////========
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.userAlt,
                                color: kThemeColor),
                            title: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Username is required';
                                }
                              },
                              decoration:
                                  InputDecoration(labelText: "Username"),
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
                              leading: FaIcon(FontAwesomeIcons.keycdn,
                                  color: kThemeColor),
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
                          SizedBox(height: 25),
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
                                          fontSize: 20.0, color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)))),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    height: 12.0,
                                    onPressed: () {},
                                    child: Text(" Terms and conditions",
                                        style: TextStyle(fontSize: 10.0))),
                                FlatButton(
                                    height: 12.0,
                                    onPressed: () {},
                                    child: Text("Privacy Policy",
                                        style: TextStyle(fontSize: 10.0)))
                              ]),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.12)),
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
