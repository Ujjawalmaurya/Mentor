import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_database/firebase_database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class DocsUpload extends StatefulWidget {
  @override
  _DocsUploadState createState() => _DocsUploadState();
}

class _DocsUploadState extends State<DocsUpload> {
  final dRefrence = FirebaseDatabase.instance.reference();

  dynamic fireStoreData;
  String getData = 'false';
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String selectedSubject = 'empty';
  String selectedClass = 'empty';
  String filename = 'empty';
  String isLoading = 'false';
  String pathSelectedClass = 'empty';
  String pathSelectedSubject = 'empty';
  Map datakey = new Map();
  Map snapShotdata = new Map();
  String title = 'empty';

  TextEditingController filenameController = TextEditingController();

  docSelecter() async {
    if (selectedClass != 'empty' &&
        selectedSubject != 'empty' &&
        title != 'empty') {
      try {
        final file = await FilePicker.getFile(
          type: FileType.custom,
          allowedExtensions: [
            'png',
            'jpeg',
            'pdf',
            'doc',
            'txt',
          ],
        );
        setState(() {
          filename = p.basename(file.path);
        });
        firebaseStorageUploader(file, filename);
      } catch (e) {
        Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Select all Fields',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  firebaseStorageUploader(file, filename) async {
    setState(() {
      isLoading = 'true';
    });
    try {
      final refDb = FirebaseStorage.instance
          .ref()
          .child(selectedClass)
          .child(selectedSubject);
      StorageReference storageReference = refDb.child("${filename}");
      final StorageUploadTask uploadTask = storageReference.putFile(file);
      final StorageTaskSnapshot downloadUrl =
          (await uploadTask.onComplete.whenComplete(() {
        Fluttertoast.showToast(
          msg: 'Success',
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }));
      final String url = (await downloadUrl.ref.getDownloadURL());
      fireDataUploader(url, filename);
    } catch (e) {
      setState(() {
        isLoading = 'false';
      });
      Fluttertoast.showToast(
        msg: e.message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  fireDataUploader(url, filename) async {
    final dbReference =
        dRefrence.child('docs').child(selectedClass).child(selectedSubject);
    await dbReference.push().set({
      "url": url,
      "filename": filename,
      "title": title,
    }).catchError((e) {
      print(e.toString());
    }).whenComplete(() {
      clearFields();
      setState(() {
        isLoading = 'false';
      });
      Fluttertoast.showToast(
        msg: 'Database Updated',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      instantRemoveListEffect(url, filename);
    });
  }

  clearFields() {
    setState(() {
      pathSelectedClass = selectedClass;
      pathSelectedSubject = selectedSubject;
    });
    setState(() {
      selectedClass = 'empty';
      selectedSubject = 'empty';
    });
  }

  getFireStoreData() async {
    if (selectedClass != 'empty' && selectedSubject != 'empty') {
      setState(() {
        isLoading = 'true';
        snapShotdata.clear();
        datakey.clear();
      });
      final db = FirebaseDatabase.instance
          .reference()
          .child('docs')
          .child(selectedClass)
          .child(selectedSubject);
      db.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;

        if (values == null) {
          setState(() {
            isLoading = 'false';
          });
          Fluttertoast.showToast(
              msg: 'No Documents uploaded',
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG);
          clearFields();
        } else {
          for (var i = 0; i < values.keys.length; i++) {
            setState(() {
              datakey[i] = values.keys.toList()[i].toString();
              snapShotdata[i] = values.values.toList()[i];
            });
          }
        }
      }).whenComplete(() {
        clearFields();
        setState(() {
          isLoading = 'false';
        });
      });
    } else {
      Fluttertoast.showToast(
        msg: 'Please select all fields',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  deleteDataKey(indexKey, index, url, filename) async {
    print(indexKey);
    final dlRef = FirebaseDatabase.instance
        .reference()
        .child('docs')
        .child(pathSelectedClass)
        .child(pathSelectedSubject);
    await dlRef.child(indexKey).remove();
    await instantRemoveListEffect(indexKey, index);

    FirebaseStorage.instance.getReferenceFromUrl(url).then((res) {
      res.delete().then((res) {
        Fluttertoast.showToast(
            msg: 'Deleted',
            backgroundColor: Colors.green,
            textColor: Colors.white);
      });
    });
  }

  void deleteCnfmBox(indexKey, index, url, filename) {
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
          content: Text('This action will delete selected Document'),
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
                deleteDataKey(indexKey, index, url, filename);
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
        .child('docs')
        .child(pathSelectedClass)
        .child(pathSelectedSubject);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;

      if (values == null) {
        setState(() {
          isLoading = 'false';
        });
        Fluttertoast.showToast(
            msg: 'All documents are removed',
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

  launchUrl(url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      Fluttertoast.showToast(
          msg: 'Oops', textColor: Colors.white, backgroundColor: Colors.green);
    }
  }

  docTitleGetter(context) {
    if (selectedClass != 'empty' && selectedSubject != 'empty') {
      Alert(
          style: AlertStyle(
              isCloseButton: false,
              alertBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          context: context,
          title: "Enter Document title",
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: filenameController,
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
                  hintText: 'Title here',
                  icon: FaIcon(FontAwesomeIcons.link, color: kThemeColor),
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
            ],
          ),
          buttons: [
            DialogButton(
              color: Colors.white,
              onPressed: () {
                if (title != 'empty') {
                  Navigator.of(context, rootNavigator: true).pop();
                  docSelecter();
                } else {
                  Fluttertoast.showToast(
                    msg: 'Enter title',
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            DialogButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            )
          ]).show();
    } else {
      Fluttertoast.showToast(
        msg: 'Select all fields first',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == 'true'
        ? Container(
            height: MediaQuery.of(context).size.height / 1,
            width: MediaQuery.of(context).size.width / 1,
            color: Colors.white,
            child: SpinKitSpinningCircle(
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
          )
        : Container(
            padding: EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height * 1,
            width: MediaQuery.of(context).size.width * 1,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        'Biology',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            getFireStoreData();
                          },
                          color: kThemeColor,
                          child: Text('Fetch',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.aspectRatio *
                                          40)),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                          elevation: 15.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          onPressed: () {
                            docTitleGetter(context);
                          },
                          color: kThemeColor,
                          child: Text(
                            'Upload',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.aspectRatio *
                                        40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                      height: MediaQuery.of(context).size.height / 20,
                      color: kThemeColor),
                  Expanded(
                      child: getData == 'true'
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: datakey.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(FontAwesomeIcons.dochub,
                                      color: kThemeColor),
                                  title: Text(snapShotdata[index]['filename']),
                                  onLongPress: () {
                                    deleteCnfmBox(
                                        datakey[index],
                                        index,
                                        snapShotdata[index]['url'],
                                        snapShotdata[index]['filename']);
                                  },
                                  onTap: () {
                                    launchUrl(snapShotdata[index]['url']);
                                  },
                                  subtitle: Text(snapShotdata[index]['title']),
                                );
                              },
                            ))
                ],
              ),
            ),
          );
  }
}
