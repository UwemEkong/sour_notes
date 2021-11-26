// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import 'package:sour_notes/models/user.dart';
import 'package:sour_notes/routes/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _fullname = "";
  @override
  @protected
  @mustCallSuper
  void initState() {
    getAuthedUser();
  }

  getAuthedUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;

    if (body.length > 1) {
      setState(() => _fullname = "Logged in as: " +
          json.decode(body)["firstName"] +
          " " +
          json.decode(body)["lastName"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('SourNotes'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
          child: new SingleChildScrollView(
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
            ElevatedButton(
              child: Text('Register'),
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
            ElevatedButton(
              child: Text('Music'),
              onPressed: () {
                Navigator.of(context).pushNamed(RouteManager.songListPage);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(_fullname!,
                  style: TextStyle(
                      height: 1.25, fontSize: 20, color: Colors.red[500])),
            ),
          ],
        ),
      )),
    );
  }
}
