// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/models/profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Profile;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Adam Chaplin'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: AssetImage(args.imageURL)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: '\n${args.bio}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue[500],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n\n Favorite Song: \n ${args.favoriteSong} \n By: ${args.favoriteSongArtist}',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.red[500])),
                          TextSpan(
                              text:
                                  '\n\n Contact: \n Phone: ${args.phoneNumber} \n E-Mail: ${args.email} \n',
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
