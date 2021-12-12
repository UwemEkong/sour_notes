import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sour_notes/pages/update_details.dart';
import 'change_password.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  String? userName = "";
  String? password = "";
  String? email = "";
  String? firstName = "";
  String? lastName = "";

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _getUserData();
    build(context);
    timer =
        Timer.periodic(const Duration(seconds: 3), (Timer t) => _getUserData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _getUserData() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;

    if (res.body.isNotEmpty) {
      setState(() => userName = json.decode(body)['username']);
      setState(() => password = '********');
      setState(() => email = json.decode(body)['email']);
      setState(() => firstName = json.decode(body)['firstName']);
      setState(() => lastName = json.decode(body)['lastName']);
    }
  }

  _logout() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/logout'
        : 'http://localhost:8080/api/auth/logout';
    await http.put(Uri.parse(url));
    setState(() => userName = '');
    setState(() => password = '');
    setState(() => email = '');
    setState(() => firstName = '');
    setState(() => lastName = '');
  }

  _reload() async {
    setState(() => userName = '');
    setState(() => password = '');
    setState(() => email = '');
    setState(() => firstName = '');
    setState(() => lastName = '');
  }

  @override
  Widget build(BuildContext context) {
    _getUserData();
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text('Reload'),
                onPressed: () {
                  _getUserData();
                },
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    text: 'UserName: ' + userName!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                          text: '\nPassword: ' + password!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nE-Mail: ' + email!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nFirst Name: ' + firstName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nLast Name: ' + lastName!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Update Details'),
                onPressed: () => goToUpdateDetails(context),
              ),
              ElevatedButton(
                child: Text('Change Password'),
                onPressed: () => goToChangePassword(context),
              ),
              ElevatedButton(
                child: Text('Log Out'),
                onPressed: () {
                  _logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  goToUpdateDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateDetailsPage(),
      ),
    );
  }

  goToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordPage(),
      ),
    );
  }
}
