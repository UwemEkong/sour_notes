import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';

import 'package:flutter/material.dart';

class SongDetailPage extends StatelessWidget {
  final Song song;

  SongDetailPage(this.song);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text(song.title),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                child: RichText(
                  text: TextSpan(
                    text: this.song.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: '\n' + this.song.artist,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              color: Colors.black)),
                      TextSpan(
                          text: '\n\n' + this.song.getNotes(),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 30,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Container(
                  // margin: EdgeInsets.all(20),
                  // child: FutureBuilder(
                  //   future: _getAllSongs(),
                  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //     // If JSON data has not arrived yet show loading
                  //     if (snapshot.data == null) {
                  //       return Container(
                  //         child: Center(
                  //           child: Text("Loading..."),
                  //         ),
                  //       );
                  //     } else {
                  //       //Once the JSON Data has arrived build the list
                  //       return ListView.builder(
                  //           scrollDirection: Axis.vertical,
                  //           shrinkWrap: true,
                  //           itemCount: snapshot.data.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             //List tile / Song row
                  //             return ListTile(
                  //               title: Text(snapshot.data[index].title),
                  //               subtitle: Text(snapshot.data[index].artist),
                  //               trailing: Text(snapshot.data[index].getNotes()),
                  //               onTap: () {
                  //                 //When user clicks the row/tile they go to the song's detail page
                  //                 Navigator.push(
                  //                     context,
                  //                     new MaterialPageRoute(
                  //                         builder: (context) => SongDetailPage(
                  //                             snapshot.data[index])));
                  //               },
                  //             );
                  //           });
                  //     }
                  // })
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
