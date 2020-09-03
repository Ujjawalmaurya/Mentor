import 'package:flutter/material.dart';
//======================================================================================

const kThemeColor = Color(0xFF651FFF);

//======================================================================================

const kContainerThemeDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage(
      "assets/home.png",
    ),
    fit: BoxFit.cover,
    alignment: Alignment.center,
  ),
);

//======================================================================================

const kSendButtonTextStyle = TextStyle(
    color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 18.0);

//======================================================================================

//                           'Hindi',
//                           'English',
//                           'Maths'
//                           'Computer'
//                           'Geography',
//                           'History',
//                           'Civics',
//                           'Economics',
//                           'Physics',
//                           'Chemistry',
//                           'Biology',
