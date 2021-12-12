import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/user.dart';
import 'package:sour_notes/pages/admin.dart';
import 'package:sour_notes/pages/home_page.dart';
import 'package:sour_notes/pages/profile_page.dart';

import '../widgets/form_input.dart';

class adminDetailsPage extends StatefulWidget {
  final User user;

  adminDetailsPage(this.user);

  @override
  State<adminDetailsPage> createState() => _adminDetailsPage();
}

class _adminDetailsPage extends State<adminDetailsPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String? _errorText = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      appBar: AppBar(
        title: Text('Update Details For ' + this.widget.user.userName),
        backgroundColor: const Color(0xFF303030),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FormInput(firstNameController,
              'First Name: ' + this.widget.user.email, 'Enter First Name'),
          FormInput(lastNameController,
              'Last Name: ' + this.widget.user.firstName, 'Enter Last Name'),
          FormInput(emailController, 'Email: ' + this.widget.user.lastName,
              'Enter Email'),
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
              onPressed: () => update(firstNameController.text,
                  lastNameController.text, emailController.text, context)),
        ],
      )),
    );
  }

  update(String firstName, String lastName, String email,
      BuildContext context) async {
    // Get current userName
    String? CurrentUserName = this.widget.user.userName;
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/admin/getUser/${CurrentUserName}'
        : 'http://localhost:8080/api/admin/getUser/${CurrentUserName}';
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
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'type': 'member',
      }),
    );

    if (response.statusCode != 200) {
      setState(() => _errorText = response.body);
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => adminPage(),
        ));
  }

  String getUrlForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/admin/updateDetails';
    } else {
      return 'http://localhost:8080/api/admin/updateDetails';
    }
  }
}
