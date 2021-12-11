import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import 'package:sour_notes/pages/home_page.dart';
import 'package:sour_notes/widgets/form_input.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

// Define a custom Form widget.
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LoginPageState extends State<LoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String? _errorText = "";
  int? attempts = 5;
  bool _isEnabled = true;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  login(String userName, String password, BuildContext context) async {
    String url = getUrlForDevice(userName, password);
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (attempts! <= 0) {
      setState(() => _isEnabled = false);
    }
    if (body == "Incorrect Username") {
      if (attempts! <= 0) {
        setState(() => attempts = attempts! + 1);
      }
      setState(() => _errorText = "Incorrect Username");
      setState(() => attempts = attempts! - 1);
    } else if (body == "Incorrect Password") {
      if (attempts! <= 0) {
        setState(() => attempts = attempts! + 1);
      }
      setState(() => _errorText = "Incorrect Password");
      setState(() => attempts = attempts! - 1);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  String getUrlForDevice(String userName, String password) {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/auth/login/$userName/$password';
    } else {
      return 'http://localhost:8080/api/auth/login/$userName/$password';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Color(0xFF303030),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormInput(userNameController, 'Username', 'Enter Valid Username'),
          FormInput(passwordController, 'Password', 'Enter Password'),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Attempts left: " "$attempts",
                style: TextStyle(
                    height: 1.25, fontSize: 20, color: Colors.red[500])),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(_errorText!,
                style: TextStyle(
                    height: 1.25, fontSize: 35, color: Colors.red[500])),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black)),
            child: Text('Login'),
            onPressed: _isEnabled
                ? () => login(
                    userNameController.text, passwordController.text, context)
                : null,
          ),
        ],
      )),
    );
  }
}
