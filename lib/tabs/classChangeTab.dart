import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClassChangeTab extends StatefulWidget {
  static const String id = "ChangeClassTab";
  @override
  _ClassChangeTabState createState() => _ClassChangeTabState();
}

class _ClassChangeTabState extends State<ClassChangeTab> {
  Map snapShotdata = new Map();
  Map datakey = new Map();
  String isLoading = 'false';
  String studentClass = "empty";

  getData() async {
    if (true) {
      setState(() {
        isLoading = 'true';
        snapShotdata.clear();
        datakey.clear();
      });
      final db = FirebaseDatabase.instance.reference().child('studentInfos');

      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;

        if (values == null) {
          setState(() {
            isLoading = 'false';
          });
          Fluttertoast.showToast(
              msg: 'No videos uploaded in this section',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
        } else {
          for (var i = 0; i < values.keys.length; i++) {
            setState(() {
              datakey[i] = values.keys.toList()[i].toString();
              snapShotdata[i] = values.values.toList()[i];
            });
          }
          setState(() {
            isLoading = 'false';
          });
        }
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Please select all fields',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  popClassSelctor(context, uid) {
    Alert(
        style: AlertStyle(isCloseButton: false),
        context: context,
        title: "Change Class",
        content: Column(
          children: <Widget>[
            ListTile(
              leading:
                  FaIcon(FontAwesomeIcons.sortNumericDown, color: kThemeColor),
              title: Text('Select Class'),
              trailing: DropdownButton<String>(
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
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
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              print(studentClass);
              changeClassFunc(uid);
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  changeClassFunc(uid) async {
    FirebaseDatabase.instance
        .reference()
        .child('studentInfos')
        .child(uid)
        .update({"class": studentClass});
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
    print(datakey.toString());
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == 'true'
        ? Container(
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: kThemeColor,
              ),
            ),
          )
        : Container(
            child: ListView.builder(
              itemCount: datakey.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapShotdata[index]['userEmail'],
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onTap: () {
                    popClassSelctor(context, snapShotdata[index]["userUid"]);
                  },
                  trailing: Text(
                    snapShotdata[index]['class'],
                    style: TextStyle(color: kThemeColor, fontSize: 20.0),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.userGraduate,
                    color: kThemeColor,
                  ),
                );
              },
            ),
          );
  }
}
