// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MirskyPage extends StatefulWidget {
  @override
  _MirskyPage createState() => _MirskyPage();
}

class _MirskyPage extends State<MirskyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Dr. Mirsky'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: AssetImage('assets/mirsky1.jpg')),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text:
                            '\nHello, my name is Dr. Mirksy! I am the owner of Sour Notes. I love pineapples.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue[500],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n\n Favorite Song: \n Pen-Pineapple-Apple-Pen \n By: Pikataro',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.red[500])),
                          TextSpan(
                              text:
                                  '\n\n Contact: \n Phone: (309) 438 - 8945 \n E-Mail: mirksydr@yahoo.com \n',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.yellow[500]))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
