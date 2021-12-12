// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/pages/home_page.dart';
import 'package:sour_notes/widgets/app.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(
          seconds: 5,
          navigateAfterSeconds: App(),
          title: new Text(
            'Welcome to SourNotes, share your thoughts and feelings about music here!',
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35.0,
                color: Colors.deepOrangeAccent),
          ),
          image: new Image.asset('assets/orange-music-note-hi.png'),
          photoSize: 100.0,
          backgroundColor: Color(0xFF303030),
          styleTextUnderTheLoader: new TextStyle(),
          loaderColor: Colors.deepOrangeAccent),
    );
  }
}
