// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import 'package:sour_notes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sour_notes/pages/admin.dart';

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
      setState(
          () => _fullname = "Logged in as: " + json.decode(body)["username"]);
    }
  }

  bool admin = false;
  checkUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (body.length > 1) {
      if (json.decode(body)["username"] == "admin") {
        admin = true;
      }
      return admin;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUser();
    return Scaffold(
      // const color = const Color(0xFF303030);,
      backgroundColor: Color(0xFF303030),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text('SourNotes',
                    style: TextStyle(
                        fontFamily: "Trajan Pro",
                        height: 1.25,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            if (admin)
              Container(
                  child: ElevatedButton(
                      child: Text('See Users'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => adminPage()));
                      }))
          ],
        ),
      )),
    );
  }

  getUsers() {}
}
