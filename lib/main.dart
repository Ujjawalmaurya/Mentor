import 'package:flutter/material.dart';
import 'package:mentor_digishala/constants.dart';
import 'package:mentor_digishala/homePage.dart';
import 'package:mentor_digishala/loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage()
      },
      title: "Mentor -DigiShala",
      theme: ThemeData.light(),
      home: LoginScreen(),
    );
  }
}

// DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             backgroundColor: Colors.deepPurpleAccent,
//             bottom: TabBar(
//               tabs: [
//                 Tab(
//                   text: 'Chat',
//                   icon: Icon(Icons.chat_bubble_outline),
//                 ),
//                 Tab(
//                   text: 'Add Videos',
//                   icon: Icon(Icons.add_box_outlined),
//                 ),
//               ],
//             ),
//             title: Text(
//               'Mentor - DigiShala',
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               Container(
//                 //===============================================Chat container
//                 decoration: kContainerThemeDecoration,
//                 child: Column(
//                   children: [
//                     RaisedButton(onPressed: () {}),
//                     RaisedButton(onPressed: () {}),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Text('Content'),
//                     Text('Chat'),
//                   ],
//                 ),
//               ),
//               Container(
//                 //===============================================Add-Video container
//                 decoration: kContainerThemeDecoration,
//                 child: Column(
//                   children: [
//                     RaisedButton(onPressed: () {}),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Text('Content'),
//                     Text('Chat'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

// MaterialApp(
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.directions_car)),
//                 Tab(icon: Icon(Icons.directions_transit)),
//                 Tab(icon: Icon(Icons.directions_bike)),
//               ],
//             ),
//             title: Text('Tabs Demo'),
//           ),
//           body: TabBarView(
//             children: [
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
