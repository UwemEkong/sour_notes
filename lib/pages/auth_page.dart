import 'package:flutter/material.dart';
import 'package:sour_notes/pages/login.dart';
import 'package:sour_notes/pages/registration_page.dart';

const Color myColor = Color(0xFFAFAFF2);

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      appBar: AppBar(
        title: const Text('SourNotes'),
        backgroundColor: const Color(0xFF303030),
      ),
      body: Center(
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
