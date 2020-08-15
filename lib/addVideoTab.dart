import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddVideoTab extends StatefulWidget {
  @override
  _AddVideoTabState createState() => _AddVideoTabState();
}

class _AddVideoTabState extends State<AddVideoTab> {
  String link;
  String selectedClass = '';
  String selectedSubject = '';
  TextEditingController linkc = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  userGetter() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email);
  }

  @override
  void initState() {
    super.initState();
    userGetter();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
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
                    return "Field is required";
                  }
                },
                onSaved: (value) {
                  setState(() {
                    link = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Paste link Here',
                  icon: Icon(
                    Icons.line_style,
                    color: Colors.purple,
                  ),
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
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              ListTile(
                leading: Text('Select Class'),
                trailing: DropdownButton<String>(
                  icon: Icon(Icons.arrow_drop_down),
                  value: (this.selectedClass == '') ? null : this.selectedClass,
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
                  items: <String>['6', '7', '8', '9', '10']
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
                  value: (this.selectedSubject == '')
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
                    'English',
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
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 10.0,
                child: Text('Upload'),
                color: Color(0xff53E0BC),
                splashColor: Color(0xffFF3031C),
                textColor: Color(0xff4C4B4B),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
