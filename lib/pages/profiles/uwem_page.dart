// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class UwemPage extends StatefulWidget {
  @override
  _UwemPage createState() => _UwemPage();
}

class _UwemPage extends State<UwemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Uwem Ekong'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text:
                      'Hello, my name is Uwem! I am the CIO and temporary table cleaner of SourNotes.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        fontSize: 25,
                        color: Colors.blue[500],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                            '\n Favorite Song: \n Never Gonna Give You Up \n By: Rick Astley',
                            style: TextStyle(fontSize: 20, color: Colors.red[500])),
                        TextSpan(
                            text:
                            '\n Contact: \n Phone: (492) 871 - 2937 \n E-Mail: ekonguwem@yahoo.com',
                            style: TextStyle(fontSize: 20, color: Colors.yellow[500]))
                      ],
                    ),
                  ),
                ),
              ),
              Image(image: AssetImage('assets/niraj1.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
