import 'package:flutter/material.dart';

const Color myColor = Color(0xFFAFAFF2);

class Header extends StatelessWidget {
  String headertype = "";
  String content = "";

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            "Hottest Tracks 🔥",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.deepOrangeAccent),
          )),
    );
  }
}
