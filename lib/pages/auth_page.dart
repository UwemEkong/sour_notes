import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sour_notes/pages/login.dart';
import 'package:sour_notes/pages/registration_page.dart';
import 'package:sour_notes/pages/user_page.dart';
import 'package:http/http.dart' as http;

const Color myColor = Color(0xFFAFAFF2);

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isAuthed = false;

  @override
  void initState() {
    checkUser();
  }

  Future<bool> checkUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (body.length > 1) {
      isAuthed = true;
      setState(() {});
      return true;
    } else {
      isAuthed = false;
      setState(() {});
      return false;
    }
  }

  getAuthed() {
    setState(() {});
    return isAuthed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      appBar: AppBar(
        title: const Text('SourNotes'),
        backgroundColor: const Color(0xFF303030),
      ),
      body: FutureBuilder<bool>(
        future: checkUser(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == false) {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(100),
                      child: Text('Sour Notes',
                          style: TextStyle(
                              height: 1.25,
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue)),
                      child: const Text('Get Started',
                          style: TextStyle(
                              height: 1.25, fontSize: 20, color: Colors.white)),
                      onPressed: () => goToRegister(context),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0))),
                      child: const Text('Sign in',
                          style: TextStyle(
                              height: 1.25,
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () => goToLogin(context),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return UserPage();
          }
        },
      ),
    );
  }

  goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(),
      ),
    );
  }

  goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
