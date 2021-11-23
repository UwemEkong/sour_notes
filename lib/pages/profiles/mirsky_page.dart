// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MirksyPage extends StatefulWidget {
  @override
  _MirksyPage createState() => _MirksyPage();
}

class _MirksyPage extends State<MirksyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Dr. Mirksy'),
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
                          'Hello, my name is Dr. Mirksy! I am the owner of Sour Notes.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        fontSize: 25,
                        color: Colors.blue[500],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '\n Favorite Song: \n Pen-Pineapple-Apple-Pen \n By: Pikataro',
                            style: TextStyle(
                                fontSize: 20, color: Colors.red[500])),
                        TextSpan(
                            text:
                                '\n Contact: \n Phone: (309) 438 - 8945 \n E-Mail: mirksydr@yahoo.com',
                            style: TextStyle(
                                fontSize: 20, color: Colors.yellow[500]))
                      ],
                    ),
                  ),
                ),
              ),
              Image(image: AssetImage('assets/mirsky1.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
