import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/docsUpload.dart';
import 'package:mentor_digishala/listDb.dart';
import 'chatTab.dart';
import 'addVideoTab.dart';

class HomePage extends StatefulWidget {
  static const String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String chatMessage;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kThemeColor,
            actions: [
              Hero(
                  tag: 'logo',
                  child: Image(image: AssetImage('assets/mascot.png')))
            ],
            bottom: TabBar(
              labelColor: Colors.yellow,
              unselectedLabelColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Colors.red,
              indicatorWeight: 2.5,
              // isScrollable: true,
              tabs: [
                Tab(icon: FaIcon(FontAwesomeIcons.facebookMessenger)),
                Tab(icon: FaIcon(FontAwesomeIcons.plusSquare)),
                Tab(icon: FaIcon(FontAwesomeIcons.database)),
                Tab(icon: FaIcon(FontAwesomeIcons.dochub)),
              ],
            ),
            title: Text('Mentor -DigiShala'),
          ),
          body: TabBarView(
            children: [
              /////=========================
              chatTab(),
              ////
              AddVideoTab(),
              ////
              ListDb(),
              ////
              DocsUpload(),
            ], ////===================================
          ),
        ),
      ),
    );
  }
}
