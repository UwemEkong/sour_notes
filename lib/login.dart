import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import './services/loginservice.dart';
import 'models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sour_notes/routes/routes.dart';
import './widgets/alert.dart';
import 'dart:convert';

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  String? _errorText = "";
  int? _attempts = 5;
  bool _isEnabled = true;
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  HttpService httpService = HttpService();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  login(String userName, String password, BuildContext context) async {
    var url = 'http://10.0.2.2:8080/api/auth/login/$userName/$password';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    print(body);
    if (_attempts! <= 0) {
      setState(() => _isEnabled = false);
    }
    if (body == "Incorrect Username") {
      if (_attempts! <= 0) {
        setState(() => _attempts = _attempts! + 1);
      }
      setState(() => _errorText = "Incorrect Username");
      setState(() => _attempts = _attempts! - 1);
      print(_attempts);
    } else if (body == "Incorrect Password") {
      if (_attempts! <= 0) {
        setState(() => _attempts = _attempts! + 1);
      }
      setState(() => _errorText = "Incorrect Password");
      setState(() => _attempts = _attempts! - 1);
      print(_attempts);
    } else {
      Navigator.of(context).pushNamed(RouteManager.homePage);
    }
  }

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter valid user name or email'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text("Attempts left: " + "$_attempts",
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
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
