import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/tabs/chatTab.dart';

class ChatGroupList extends StatefulWidget {
  @override
  _ChatGroupListState createState() => _ChatGroupListState();
}

class _ChatGroupListState extends State<ChatGroupList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.arrowLeft),
            title: Text('Class 7'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "7");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.arrowLeft),
            title: Text('Class 8'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "8");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.arrowLeft),
            title: Text('Class 9'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "9");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.arrowLeft),
            title: Text('Class 10'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "10");
                },
              ));
            },
          ),
        ],
      ),
    );
  }
}
