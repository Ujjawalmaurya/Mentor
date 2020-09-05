import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/tabs/docsUpload.dart';
import 'package:mentor_digishala/tabs/listDb.dart';
import 'package:mentor_digishala/tabs/textingTabs.dart';
import 'tabs/chatTab.dart';
import 'tabs/broadCastTab.dart';
import 'tabs/addVideoTab.dart';
import 'tabs/classChangeTab.dart';
import 'tabs/chatGroupList.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String chatMessage;
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    AddVideoTab(),
    ListDb(),
    DocsUpload(),
    ClassChangeTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: const Text('Mentor -DigiShala'),
          backgroundColor: kThemeColor,
          actions: [
            IconButton(
                icon: FaIcon(FontAwesomeIcons.envelopeOpenText),
                tooltip: "Chats and Broadcast",
                onPressed: () {
                  Navigator.pushNamed(context, TextingTabs.id);
                }),
            IconButton(
                icon: FaIcon(FontAwesomeIcons.plusCircle),
                tooltip: "Add New Student",
                onPressed: () {
                  Navigator.pushNamed(context, "signup");
                }),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.pinkAccent, boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.pinkAccent,
            )
          ]),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: GNav(
                  color: Colors.white,
                  gap: 15,
                  activeColor: Colors.white,
                  iconSize: 25,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: kThemeColor,
                  tabs: [
                    GButton(
                      icon: FontAwesomeIcons.plusSquare,
                      text: 'Add a Video',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.database,
                      text: 'Fetch Videos',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.dochub,
                      text: 'Fetch Documents',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.calendarAlt,
                      text: 'Change Class',
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
      ),
    );
  }
}
