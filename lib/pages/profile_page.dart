// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/models/profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(profile.name),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: AssetImage(profile.imageURL)),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: '\n${profile.bio}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.blue[500],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '\n\n Favorite Song: \n ${profile.favoriteSong} \n By: ${profile.favoriteSongArtist}',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.red[500])),
                          TextSpan(
                              text:
                                  '\n\n Contact: \n Phone: ${profile.phoneNumber} \n E-Mail: ${profile.email} \n',
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
