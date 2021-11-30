import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getUserData());
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

  @override
  Widget build(BuildContext context) {
    _getUserData();
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Welcome ' + firstName!),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    text: 'UserName: ' + userName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                          text: '\nPassword: ' + password!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nE-Mail: ' + email!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nFirst Name: ' + firstName!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                      TextSpan(
                          text: '\nLast Name: ' + lastName!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () {
                  _logout();
                },
              ),
              // ElevatedButton(
              //   child: const Text('Log Out'),
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const MyCustomForm(),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
