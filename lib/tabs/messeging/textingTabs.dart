import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/tabs/messeging/broadCastTab.dart';
import 'package:mentor_digishala/tabs/messeging/chatGroupList.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TextingTabs extends StatefulWidget {
  static const String id = 'TextingTabs';
  @override
  _TextingTabsState createState() => _TextingTabsState();
}

class _TextingTabsState extends State<TextingTabs> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ChatGroupList(),
    BroadCastTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kThemeColor,
          title: Text(
            'Chats and Announcements',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.056),
          )),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: kThemeColor, boxShadow: [
          BoxShadow(blurRadius: 20, color: kThemeColor.withOpacity(.3))
        ]),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: GNav(
                color: Colors.white,
                gap: MediaQuery.of(context).size.width * 0.03,
                activeColor: Colors.white,
                iconSize: MediaQuery.of(context).size.width * 0.055,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3.5),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.pinkAccent,
                tabs: [
                  GButton(
                    icon: FontAwesomeIcons.solidComments,
                    text: 'Chats and Discussions',
                    textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  GButton(
                    icon: FontAwesomeIcons.bullhorn,
                    text: 'Broadcast/Announce',
                    textStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
