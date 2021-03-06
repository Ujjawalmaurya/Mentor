import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AddVideoTab extends StatefulWidget {
  @override
  _AddVideoTabState createState() => _AddVideoTabState();
}

class _AddVideoTabState extends State<AddVideoTab> {
  bool isUploading = false;
  final dRefrence = FirebaseDatabase.instance.reference();
  String title = 'empty';
  String link;
  String selectedClass = 'empty';
  String selectedSubject = 'empty';
  TextEditingController linkc = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  userGetter() async {
    User user = FirebaseAuth.instance.currentUser;
    print(user.email);
  }

  Future<dynamic> getTitle(String linkUrl) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$linkUrl&format=json";

    //store http request response to res variable
    var res = await http.get(embedUrl);
    print(res.toString());
    print("get youtube detail status code: " + res.statusCode.toString());

    try {
      if (res.statusCode == 200) {
        //return the json from the response
        return json.decode(res.body);
      } else {
        //return null if status code other than 200
        return null;
      }
    } on FormatException catch (e) {
      print('invalid JSON' + e.toString());
      //return null if error
      return null;
    }
  }

  fetchUrl() async {
    String videoUrl = this.link;

    var jsonData = await getTitle(videoUrl);
    setState(() {
      title = jsonData['title'];
    });
  }

  //upload links to firebase db
  uploadVideoLink() async {
    if (link.isNotEmpty &&
        selectedClass != 'empty' &&
        selectedSubject != 'empty' &&
        title != 'empty') {
      setState(() {
        isUploading = true;
      });
      final dbReference = dRefrence.child(selectedClass).child(selectedSubject);
      await dbReference.push().set({
        "link": link,
        "title": title,
      }).catchError((e) {
        print(e.toString());
      }).whenComplete(() => clearFields());
    } else {
      Fluttertoast.showToast(
          msg: "Please fill all fields Correctly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //after upload this fxn will clean all fields
  clearFields() {
    setState(() {
      selectedClass = 'empty';
      selectedSubject = 'empty';
      title = 'empty';
    });
    linkc.clear();
    setState(() {
      isUploading = false;
    });
    Fluttertoast.showToast(
        msg: 'Link Uploaded to db',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT);
  }

  titleChanger() {
    Alert(
        style: AlertStyle(isCloseButton: false),
        context: context,
        title: "Edit title",
        content: Column(
          children: <Widget>[
            ListTile(
              title: TextFormField(
                initialValue: title,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Field is required";
                  }
                },
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                  focusColor: Colors.blueGrey,
                  hoverColor: kThemeColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  void initState() {
    super.initState();
    userGetter();
  }

  @override
  Widget build(BuildContext context) {
    return isUploading == true
        ? Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
            color: Colors.white,
            child: SpinKitThreeBounce(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                  ),
                );
              },
            ),
          )
        : SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: 30.0,
                  bottom: 20.0,
                  left: 10.0,
                  right: 10.0,
                ),

                // height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 1,
                alignment: Alignment.topCenter,
                child: Form(
                    key: _key,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: linkc,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Video link is required";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                link = value;
                              });
                              fetchUrl();
                            },
                            decoration: InputDecoration(
                              hintText: 'Paste Video Link Here',
                              icon: FaIcon(FontAwesomeIcons.link,
                                  color: kThemeColor),
                              //   Icon(
                              // Icons.line_style,
                              // color: Colors.purple,
                              // ),
                              focusColor: Colors.blueGrey,
                              hoverColor: Colors.purple,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.07,
                            color: kThemeColor,
                          ),
                          ListTile(
                            leading: Text('Select Class'),
                            trailing: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              value: (this.selectedClass == 'empty')
                                  ? null
                                  : this.selectedClass,
                              hint: Text('Select class'),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: kThemeColor),
                              underline: Container(
                                height: 2,
                                color: kThemeColor,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedClass = newValue;
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
                          ListTile(
                            leading: Text('Select Subject'),
                            trailing: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              value: (this.selectedSubject == 'empty')
                                  ? null
                                  : this.selectedSubject,
                              hint: Text('Select Subject'),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: kThemeColor),
                              underline: Container(
                                height: 2,
                                color: kThemeColor,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  selectedSubject = newValue;
                                });
                              },
                              items: <String>[
                                'Hindi',
                                'English',
                                'Maths',
                                'Computer',
                                'Geography',
                                'History',
                                'Civics',
                                'Economics',
                                'Physics',
                                'Chemistry',
                                'Biology'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Divider(
                              color: kThemeColor,
                              height:
                                  MediaQuery.of(context).size.height * 0.07),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Title Shows below',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 18),
                                ),
                                ListTile(
                                  title: Text(
                                    this.title == null
                                        ? ('null..')
                                        : (this.title),
                                  ),
                                  trailing: GestureDetector(
                                    child: FaIcon(FontAwesomeIcons.edit),
                                    onTap: () {
                                      titleChanger();
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: MediaQuery.of(context).size.height * 0.07,
                            color: kThemeColor,
                          ),
                          Container(
                            // Upload Button
                            height: MediaQuery.of(context).size.width * 0.11,
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: RaisedButton(
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  _key.currentState.save();
                                  uploadVideoLink();
                                }
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              elevation: 15.0,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text('Upload Video'),
                              ),
                              color: kThemeColor,
                              textColor: Colors.white,
                            ),
                          )
                        ])),
              ),
            ),
          );
  }
}
