import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/tabs/messeging/chatTab.dart';

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
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 1',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "1");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 2',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "2");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 3',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "3");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 4',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "4");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 5',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "5");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 6',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "6");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 7',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "7");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 8',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "8");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 9',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return chatTab(studentClass: "9");
                },
              ));
            },
          ),
          ListTile(
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: kThemeColor,
            ),
            title: Text('Class 10',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            leading: FaIcon(FontAwesomeIcons.graduationCap,
                color: kThemeColor, size: 30.0),
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
