// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class NirajPage extends StatefulWidget {
  @override
  _NirajPage createState() => _NirajPage();
}

class _NirajPage extends State<NirajPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Niraj Patel'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text:
                            'Hello, my name is Niraj! I am the CMO and temporary dish washer of SourNotes.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
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
                                  '\n\n Contact: \n Phone: (309) 438 - 8945 \n E-Mail: patelniraj@yahoo.com \n',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.yellow[500]))
                        ],
                      ),
<<<<<<< Updated upstream
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '\n\n Favorite Song: \n Never Gonna Give You Up \n By: Rick Astley',
                            style: TextStyle(
                                fontSize: 20, color: Colors.red[500])),
                        TextSpan(
                            text:
                                '\n\n Contact: \n Phone: (309) 438 - 8945 \n E-Mail: patelniraj@yahoo.com \n',
                            style: TextStyle(
                                fontSize: 20, color: Colors.yellow[500]))
                      ],
=======
>>>>>>> Stashed changes
                    ),
                  ),
                ),
                Image(image: AssetImage('assets/niraj1.jpg'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
