// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class AdamPage extends StatefulWidget {
  @override
  _AdamPage createState() => _AdamPage();
}

class _AdamPage extends State<AdamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Adam Chaplin'),
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
                          'Hello, my name is Adam! I am the COO and temporary floor sweeper of SourNotes.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        fontSize: 25,
                        color: Colors.blue[500],
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                '\n\n Favorite Song: \n 3005 \n By: Childish Gambino',
                            style: TextStyle(
                                fontSize: 20, color: Colors.red[500])),
                        TextSpan(
                            text:
                                '\n\n Contact: \n Phone: (957) 247 - 1214 \n E-Mail: chaplinadam@yahoo.com \n',
                            style: TextStyle(
                                fontSize: 20, color: Colors.yellow[500]))
                      ],
                    ),
                  ),
                ),
              ),
              Image(image: AssetImage('assets/adam1.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
