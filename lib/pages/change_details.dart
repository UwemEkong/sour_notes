import 'package:flutter/material.dart';
import 'package:sour_notes/widgets/form_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ChangeDetailsPage extends StatefulWidget {
  const ChangeDetailsPage({Key? key}) : super(key: key);

  @override
  _ChangeDetailsPageState createState() => _ChangeDetailsPageState();
}

class _ChangeDetailsPageState extends State<ChangeDetailsPage> {

  String? _errorText = "";
  int? attempts = 5;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  update(String firstName, String lastName, String email,
      String password, BuildContext context) async {

    // Get current userName
    String? CurrentUserName = "";
    var url = Platform.isAndroid
          ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
          : 'http://localhost:8080/api/auth/getloggedinuser';
      var res = await http.get(Uri.parse(url));
      var body = res.body;

      if (res.body.isNotEmpty) {
        setState(() => CurrentUserName = json.decode(body)['username']);
      }


    // Edit current userName's profile details
    final response = await http.post(
      Uri.parse(getUrlForDevice()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': CurrentUserName!,
        'password': password,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'type': 'member',
      }),
    );

    if (response.statusCode != 200) {
      setState(() => _errorText = response.body);
    } else {
      Navigator.pop(context, true);
    }
  }

  String getUrlForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/auth/update';
    } else {
      return 'http://localhost:8080/api/auth/update';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      appBar: AppBar(
        title: const Text('Update Details'),
        backgroundColor: const Color(0xFF303030),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormInput(firstNameController, 'First Name', 'Enter First Name'),
          FormInput(lastNameController, 'Last Name', 'Enter Last Name'),
          FormInput(emailController, 'Email', 'Enter valid email'),
          FormInput(passwordController, 'Password', 'Enter password'),
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
            child: Text('Update'),
            onPressed: () => update(
                firstNameController.text,
                lastNameController.text,
                emailController.text,
                passwordController.text,
                context),
          ),
        ],
      )),
    );
  }
}



