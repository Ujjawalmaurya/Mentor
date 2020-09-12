import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'package:mentor_digishala/tabs/docsUpload.dart';
import 'package:mentor_digishala/tabs/videoTabs/listDb.dart';
import 'package:mentor_digishala/tabs/messeging/textingTabs.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'tabs/videoTabs/addVideoTab.dart';
import 'tabs/classChangeTab.dart';
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

  signoutConfmBox(context) {
    Alert(
        style: AlertStyle(
            isCloseButton: false,
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        context: context,
        title: "Attention!!",
        content: Text(
          'Do You Want to Logout??',
          style: TextStyle(color: Colors.red),
        ),
        buttons: [
          DialogButton(
            color: Colors.white,
            onPressed: () {
              signOut();
            },
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          ),
          DialogButton(
              color: Colors.white,
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              })
        ]).show();
  }

  Future<void> signOut() async {
    try {
      Navigator.of(context, rootNavigator: true).pop();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              'Mentor -DigiShala',
            ),
          ),
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
            IconButton(
                icon: FaIcon(FontAwesomeIcons.signOutAlt),
                tooltip: "Add New Student",
                onPressed: () {
                  signoutConfmBox(context);
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
              child: GNav(
                  color: Colors.white,
                  gap: MediaQuery.of(context).size.width * 0.08,
                  activeColor: Colors.white,
                  iconSize: MediaQuery.of(context).size.width * 0.055,
                  // iconSize: 25.0,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  duration: Duration(milliseconds: 500),
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
                      text: 'Documents',
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
