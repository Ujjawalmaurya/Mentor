import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/tabs/docsUpload.dart';
import 'package:mentor_digishala/tabs/listDb.dart';
import 'tabs/chatTab.dart';
import 'tabs/broadCastTab.dart';
import 'tabs/addVideoTab.dart';
import 'tabs/classChangeTab.dart';
import 'tabs/chatGroupList.dart';

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
        initialIndex: 2,
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kThemeColor,
            actions: [
              Hero(
                tag: 'logo',
                child: IconButton(
                    icon: Image(
                      image: AssetImage('assets/mascot.png'),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "signup");
                    }),
              )
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
                Tab(icon: FaIcon(Icons.chat)),
                Tab(icon: FaIcon(FontAwesomeIcons.broadcastTower)),
                Tab(icon: FaIcon(FontAwesomeIcons.plusSquare)),
                Tab(icon: FaIcon(FontAwesomeIcons.database)),
                Tab(icon: FaIcon(FontAwesomeIcons.dochub)),
                Tab(icon: FaIcon(FontAwesomeIcons.calendarAlt)),
              ],
            ),
            title: Text('Mentor -DigiShala'),
          ),
          body: TabBarView(
            children: [
              /////=========================
              ChatGroupList(),
              ////
              BroadCastTab(),
              /////
              AddVideoTab(),
              ////
              ListDb(),
              ////
              DocsUpload(),

              ClassChangeTab(),
            ], ////===================================
          ),
        ),
      ),
    );
  }
}
