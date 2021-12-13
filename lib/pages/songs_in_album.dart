import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/music.dart';
import 'dart:io' show Platform;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';

import '../models/review.dart';
import '../widgets/form_input.dart';

class SongsInAlbumPage extends StatefulWidget {
  final Music music;

  SongsInAlbumPage(this.music);

  @override
  State<SongsInAlbumPage> createState() => _SongsInAlbum();
}

class _SongsInAlbum extends State<SongsInAlbumPage> {
  Future<List<String>> _getAllSongsUnderAlbum() async {
    String url = this.widget.music.deezerUrl;

    var res = await http.get(Uri.parse(url));
    var body = res.body;
    var jsonData = json.decode(body);

    List<String> songNames = [];

    if (this.widget.music.isSong) {
      return songNames;
    }

    for (var s in jsonData["tracks"]["data"]) {
      songNames.add(s["title"]);
    }

    return songNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: Text(widget.music.title),
        backgroundColor: Color(0xFF303030),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(40),
                  child: Column(children: [
                    //Cover Art
                    FutureBuilder(
                        future: this.widget.music.getCoverArt(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          // If JSON data has not arrived yet show loading
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text("Loading Image..."),
                              ),
                            );
                          } else {
                            //Once the JSON Data has arrived build the list
                            return Image.network(snapshot.data.toString());
                          }
                        }),
                    RichText(
                      text: TextSpan(
                        text: this.widget.music.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                              text: '\n' + this.widget.music.artist,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Colors.black)),
                          TextSpan(
                              text: '\n\n' + this.widget.music.getNotes(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    //Songs under Album
                    FutureBuilder(
                        future: _getAllSongsUnderAlbum(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          // If JSON data has not arrived yet show loading
                          if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: Text("Loading..."),
                              ),
                            );
                          } else {
                            //Once the JSON Data has arrived build the list
                            return ListView.builder(
                                physics: const PageScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //List tile / Song row
                                  return ListTile(
                                    title: Text(snapshot.data[index]),
                                  );
                                });
                          }
                        }),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}



// }
