import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentor_digishala/constants.dart';

class BroadCastTab extends StatefulWidget {
  @override
  _BroadCastTabState createState() => _BroadCastTabState();
}

class _BroadCastTabState extends State<BroadCastTab> {
  final clearMessage = TextEditingController();
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;

  FirebaseUser loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('broadcast')
                .orderBy('time', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 1,
                        child: SpinKitCubeGrid(
                            itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                              decoration: BoxDecoration(
                                  color:
                                      index.isEven ? Colors.red : kThemeColor));
                        })));
              }
              final messages = snapshot.data.documents.reversed;
              List<Bubble> messageWidgets = [];
              for (var message in messages) {
                final messageText = message.data['text'];
                final messageSender = message.data['sender'];
                final timeOfMsg = message.data['timeOfMsg'];
                final currentUser = loggedInUser.email;
                final messageWidget = Bubble(
                  sender: messageSender,
                  text: messageText,
                  timeOfMsg: timeOfMsg,
                  itsMeOrNot: currentUser == messageSender,
                );
                messageWidgets.add(messageWidget);
              }
              return Expanded(
                  child: ListView(
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      children: messageWidgets));
            },
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.pinkAccent, width: 2.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: clearMessage,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: 'Announce/Broadcast...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    //https://stackoverflow.com/questions/16126579/how-do-i-format-a-date-with-dart
                    //condition to check empty messge and nulls
                    if (messageText != null && messageText.trim().length != 0) {
                      final DateTime now = DateTime.now();
                      clearMessage.clear(); // Clears the message
                      _firestore.collection('broadcast').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'time': Timestamp.now().millisecondsSinceEpoch,
                        'timeOfMsg': DateFormat().format(now),
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Enter text',
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_SHORT);
                      clearMessage.clear();
                    }
                  },
                  child: Text(
                    'Announce',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  Bubble({this.sender, this.text, this.itsMeOrNot, this.timeOfMsg});

  final String sender;
  final String text;
  final String timeOfMsg;
  final bool itsMeOrNot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${timeOfMsg} -School Management",
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w900),
          ),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 15.0,
            // type: MaterialType.button,
            shadowColor: Colors.deepOrangeAccent,
            color: Colors.deepOrangeAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('${text}',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300)),
            ),
          ),
        ],
      ),
    );
  }
}
