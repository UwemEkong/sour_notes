// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class GurkiratPage extends StatefulWidget {
  @override
  _GurkiratPage createState() => _GurkiratPage();
}

class _GurkiratPage extends State<GurkiratPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Gurkirat Gill'),
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
                          'Hello, my name is Gurkirat! I am the CFO and temporary window washer of SourNotes.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        fontSize: 25,
                        color: Colors.blue[500],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '\n\n Favorite Song: \n Never Gonna Give You Up \n By: Rick Astley',
                            style: TextStyle(
                                fontSize: 20, color: Colors.red[500])),
                        TextSpan(
                            text:
                                '\n\n Contact: \n Phone: (805) 629 - 4759 \n E-Mail: gillgurkirat@yahoo.com \n',
                            style: TextStyle(
                                fontSize: 20, color: Colors.yellow[500]))
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
