import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            actions: [
              Hero(
                  tag: 'logo',
                  child: Image(image: AssetImage('assets/mascot.png')))
            ],
            bottom: TabBar(
              indicatorWeight: 4.5,
              indicatorColor: Colors.amberAccent,
              // isScrollable: true,
              tabs: [
                Tab(
                    icon: FaIcon(FontAwesomeIcons.facebookMessenger),
                    text: 'Chats'),
                Tab(
                    icon: FaIcon(FontAwesomeIcons.plusSquare),
                    text: 'Add a Video'),
              ],
            ),
            title: Text('Mentor -DigiShala'),
          ),
          body: TabBarView(
            children: [
              ///===============================================================Chats Tab
              chatTab(),

              ///===============================================================Adding Video Tab
              AddVideoTab(),
            ],
          ),
        ),
      ),
    );
  }
}
