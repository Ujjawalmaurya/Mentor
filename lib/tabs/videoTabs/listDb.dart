import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';

class ListDb extends StatefulWidget {
  @override
  _ListDbState createState() => _ListDbState();
}

class _ListDbState extends State<ListDb> {
  String isLoading = 'false';
  String selectedClass = 'empty';
  String selectedSubject = 'empty';
  String pathSelectedSubject = 'empty';
  String pathSelectedClass = 'empty';
  Map datakey = new Map();
  Map snapShotdata = new Map();
  getData() async {
    if (selectedClass != 'empty' && selectedSubject != 'empty') {
      setState(() {
        isLoading = 'true';
        snapShotdata.clear();
        datakey.clear();
      });
      final db = FirebaseDatabase.instance
          .reference()
          .child(selectedClass)
          .child(selectedSubject);
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
          clearEnteredData();
        } else {
          for (var i = 0; i < values.keys.length; i++) {
            setState(() {
              datakey[i] = values.keys.toList()[i].toString();
              snapShotdata[i] = values.values.toList()[i];
            });
          }
        }
      }).whenComplete(() => clearEnteredData());
    } else {
      Fluttertoast.showToast(
        msg: 'Please select all fields',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  clearEnteredData() {
    setState(() {
      pathSelectedClass = selectedClass;
      pathSelectedSubject = selectedSubject;
    });
    setState(() {
      selectedClass = 'empty';
      selectedSubject = 'empty';
      isLoading = 'false';
    });
  }

  deleteDataKey(indexKey, index) async {
    print(indexKey);
    final dlRef = FirebaseDatabase.instance
        .reference()
        .child(pathSelectedClass)
        .child(pathSelectedSubject);
    await dlRef.child(indexKey).remove();
    await instantRemoveListEffect(indexKey, index);
  }

  void deleteCnfmBox(indexKey, index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: Text(
            'Alert',
            style: TextStyle(color: Colors.red),
          ),
          content: Text('This action will delete selected Video'),
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
              child: Text("Cancel"),
            ),
            FlatButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.red, width: 2),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                deleteDataKey(indexKey, index);
              },
              child: Text("Ok"),
            )
          ],
        );
      },
    );
  }

  instantRemoveListEffect(indexKey, index) {
    setState(() {
      isLoading = 'true';
      snapShotdata.clear();
      datakey.clear();
    });
    print(pathSelectedSubject);
    print(pathSelectedClass);
    final db = FirebaseDatabase.instance
        .reference()
        .child(pathSelectedClass)
        .child(pathSelectedSubject);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;

      if (values == null) {
        setState(() {
          isLoading = 'false';
        });
        Fluttertoast.showToast(
            msg: 'All videos are removed',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_LONG);
      } else {
        setState(() {
          isLoading = 'false';
        });
        for (var i = 0; i < values.keys.length; i++) {
          setState(() {
            datakey[i] = values.keys.toList()[i].toString();
            snapShotdata[i] = values.values.toList()[i];
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height * 1,
        width: MediaQuery.of(context).size.width * 1,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          ListTile(
            leading: Text('Select Class'),
            trailing: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down),
              value:
                  (this.selectedClass == 'empty') ? null : this.selectedClass,
              hint: Text('Select class'),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  selectedClass = newValue;
                });
              },
              items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                  .map<DropdownMenuItem<String>>((String value) {
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
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.07,
            child: RaisedButton(
              elevation: 15,
              onPressed: () {
                getData();
              },
              child: Text('Fetch Video Details',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.aspectRatio * 40)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: kThemeColor,
              textColor: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Divider(color: kThemeColor),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Expanded(
              child: isLoading == 'true'
                  ? Container(
                      height: MediaQuery.of(context).size.height / 1,
                      width: MediaQuery.of(context).size.width / 1,
                      color: Colors.white,
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
                  : ListView.builder(
                      itemCount: datakey.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(FontAwesomeIcons.solidFileVideo,
                                  color: kThemeColor),
                              title: Text(snapShotdata[index]['title']),
                              onLongPress: () {
                                deleteCnfmBox(datakey[index], index);
                              },
                            ),
                            Divider(color: kThemeColor),
                          ],
                        );
                      }))
        ]));
  }
}
