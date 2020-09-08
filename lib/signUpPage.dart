import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'registration';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController studentClassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey();
  String isLoading = 'false';
  String email, pass, confPass, errorMsg;
  String studentClass = 'empty';

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
              content: Text('fill All fields coreectly'),
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

  clearFields() async {
    cPassController.clear();
    passController.clear();
    usernameController.clear();
  }

  register() async {
    setState(() {
      isLoading = 'true';
    });
    FirebaseApp app = await FirebaseApp.configure(
        name: 'Secondary', options: await FirebaseApp.instance.options);
    return FirebaseAuth.fromApp(app)
        .createUserWithEmailAndPassword(email: email, password: pass);
  }

  writeUUIdWithClass(newUser) async {
    final dRefrence = FirebaseDatabase.instance.reference();
    if (newUser != null) {
      final dbReference =
          dRefrence.child("studentInfos").child(newUser.user.uid);
      await dbReference.set({
        "class": studentClass,
        "userEmail": newUser.user.email,
        "userUid": newUser.user.uid,
      }).catchError((e) {
        print(e.toString());
      }).whenComplete(() => clearFields());
    } else {
      Fluttertoast.showToast(
          msg: "Oops",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == 'true'
        ? Container(
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
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
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.02)),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                    image: AssetImage('assets/reg-asset.jpg'))),
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.width * 0.6,
                          ),
                          SizedBox(height: 10.0),
                          //==========
                          //Username
                          ////========
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.userAlt,
                              color: kThemeColor,
                            ),
                            title: TextFormField(
                              controller: usernameController,
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
                              leading: FaIcon(
                                FontAwesomeIcons.userLock,
                                color: kThemeColor,
                              ),
                              title: TextFormField(
                                  controller: passController,
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
                                      this.pass = input;
                                    });
                                    print(this.pass);
                                  })),
                          ////===============
                          ///Confirm Password
                          ////===============
                          ListTile(
                              leading: FaIcon(
                                FontAwesomeIcons.userLock,
                                color: kThemeColor,
                              ),
                              title: TextFormField(
                                  controller: cPassController,
                                  obscureText: true,
                                  validator: (input) {
                                    if (input.isEmpty) {
                                      return 'Confirmation Password is required';
                                    } else if (input.length < 6) {
                                      return ' Confirmed Password is too short';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Confirm Password"),
                                  onSaved: (input) {
                                    setState(() {
                                      this.confPass = input;
                                    });
                                    print(this.confPass);
                                  })),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.sortNumericDown,
                              color: kThemeColor,
                            ),
                            title: Text('Select Class'),
                            trailing: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              value: (this.studentClass == 'empty')
                                  ? null
                                  : this.studentClass,
                              hint: Text('Select class'),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: kThemeColor),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  studentClass = newValue;
                                });
                              },
                              items: <String>[
                                '1',
                                '2',
                                '3',
                                '4',
                                '5',
                                '6',
                                '7',
                                '8',
                                '9',
                                '10'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.018)),
                          Container(
                              height: 50.0,
                              width: 250.0,
                              /////////////////////////////////////////////////////
                              ///===========Add New Student Button======///////////
                              /////////////////////////////////////////////////////
                              child: RaisedButton(
                                  onPressed: () async {
                                    // print("email: ${email} and pass: ${pass}");
                                    if (_key.currentState.validate()) {
                                      _key.currentState.save();
                                      if (pass == confPass &&
                                          studentClass != 'empty') {
                                        try {
                                          final newUser = await register();
                                          if (newUser != null) {
                                            writeUUIdWithClass(newUser);
                                            //Message after sucessfull user creation
                                            Fluttertoast.showToast(
                                              msg:
                                                  "${newUser.user.email}+ Added Sucesfully in database",
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            clearFields();
                                            setState(() {
                                              isLoading = 'false';
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            errorMsg = e.message;
                                            isLoading = 'false';
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.plus,
                                        color: Colors.deepOrangeAccent,
                                      ),
                                      SizedBox(width: 8),
                                      Text("Add New Student ",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white)),
                                    ],
                                  )
                                  //
                                  ,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)))),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.1)),
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
