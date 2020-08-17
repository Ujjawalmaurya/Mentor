import 'package:flutter/material.dart';
import 'package:mentor_digishala/loginPage.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: kContainerThemeDecoration,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ////================================================================
            RaisedButton(
              child: Text('Log IN'),
              onPressed: () async {
                /// Add Function to logout Button
                final _login = await SharedPreferences.getInstance();
                bool login = await _login.setBool('islog', true);
                print(login);
              },
              color: Colors.indigo,
            ), ///////////////////////////////////////////
            RaisedButton(
              child: Text('check'),
              onPressed: () async {
                /// Add Function to logout Button
                SharedPreferences _login =
                    await SharedPreferences.getInstance();
                final login = _login.getBool('isloged') ?? false;
                print("Status: $login");
              },
              color: Colors.indigo,
            ), ////////////////////////////////////////////////
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                /// Add Function to logout Button
                SharedPreferences _login =
                    await SharedPreferences.getInstance();
                bool login = await _login.setBool('islog', false);
                print(login);
              },
              color: Colors.indigo,
            ), ////=========================================================
            SizedBox(
              // child: Text("Used Sized Box for distance"),
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        // chatMessage = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
