import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/homePage.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'registration';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String email, pass, confPass, errorMsg;

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

  ///Pass Not Match dialog
  errorPassDialog() {
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
              content: Text('Passwords are not matching'),
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
                  child: Text("Retry"),
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
                            email = input + '@student.nca';
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
                            decoration: InputDecoration(labelText: "Password"),
                            onSaved: (input) {
                              setState(() {
                                this.pass = input;
                              });
                              print(this.pass);
                            })),
                    ////===============
                    ///Confirm Password
                    ////===============
                    ListTile(
                        leading: FaIcon(FontAwesomeIcons.lock),
                        title: TextFormField(
                            obscureText: true,
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Confirmation Password is required';
                              } else if (input.length < 6) {
                                return ' Confirmed Password is too short';
                              }
                            },
                            decoration:
                                InputDecoration(labelText: "Confirm Password"),
                            onSaved: (input) {
                              setState(() {
                                this.confPass = input;
                              });
                              print(this.confPass);
                            })),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.02)),
                    Container(
                        height: 50.0,
                        width: 220.0,
                        /////////////////////////////////////////////////////
                        ///===========Add New Student Button======///////////
                        /////////////////////////////////////////////////////
                        child: RaisedButton(
                            onPressed: () async {
                              // print("email: ${email} and pass: ${pass}");
                              if (_key.currentState.validate()) {
                                _key.currentState.save();
                                if (pass == confPass) {
                                  try {
                                    final newUser = await _auth
                                        .createUserWithEmailAndPassword(
                                            email: email, password: pass);
                                    if (newUser != null) {
                                      Navigator.pushReplacementNamed(
                                          context, HomePage.id);
                                    }
                                  } catch (e) {
                                    setState(() {
                                      errorMsg = e.message;
                                    });
                                    errorDialog();
                                  }
                                } else {
                                  errorPassDialog();
                                }
                              }
                            },
                            color: Colors.lightBlueAccent,
                            splashColor: Colors.deepPurpleAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: Colors.deepOrangeAccent,
                                ),
                                Text("Add New Student",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                              ],
                            )
                            //
                            ,
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

/////===========================================================================
// signup execution

// onPressed: () async {
//                 print("${email} and ${pass}");

//                 try {
//                   final newUser = await _auth.createUserWithEmailAndPassword(
//                       email: email, password: pass);
//                   if (newUser != null) {
//                     Navigator.pushNamed(context, HomePage.id);
//                   }
//                 } catch (e) {
//                   print(e);
//                 }
//               },
////============================================================================
