// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('SourNotes'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('Welcome to SourNotes!',
                  style: TextStyle(
                      height: 1.25, fontSize: 35, color: Colors.red[500])),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.loginPage);
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('About Us'),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.aboutUsPage);
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
