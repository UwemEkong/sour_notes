// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sour_notes/models/loginmessage.dart';
import 'package:sour_notes/models/music.dart';
import 'package:sour_notes/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sour_notes/widgets/header.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sour_notes/widgets/song_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAdmin = true;
  String? _fullname = "";
  @override
  @protected
  @mustCallSuper
  void initState() {
    getAuthedUser();
  }

  getAuthedUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;

    if (body.length > 1) {
      setState(
          () => _fullname = "Logged in as: " + json.decode(body)["username"]);
    }
  }

  bool admin = false;
  checkUser() async {
    var test = '';
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (body.length > 1) {
      if (json.decode(body)["username"] == "admin") {
        return !admin;
      } else {
        return admin;
      }
    }
    throw NullThrownError();
  }

  getUrlForMusicForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/music/';
    } else {
      return 'http://localhost:8080/api/music/';
    }
  }

  Future<List<Music>> _getAllSongs() async {
    String url = getUrlForMusicForDevice() + "getSongsOnly";

    var res = await http.get(Uri.parse(url));
    var body = res.body;
    print(body);
    var jsonData = json.decode(body);

    List<Music> musicList = [];

    for (var s in jsonData) {
      Music music = Music(
          id: s["id"],
          deezerUrl: s["deezerUrl"],
          isSong: s["song"],
          title: s["title"],
          artist: s["artist"],
          rating: s["averageRating"]);

      musicList.add(music);
    }

    return musicList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SourNotes'),
          backgroundColor: Color(0xFF303030),
        ),
        // const color = const Color(0xFF303030);,
        backgroundColor: Color(0xFF303030),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
            child: Column(children: <Widget>[
              Header(),
              Container(
                  child: FutureBuilder(
                      future: _getAllSongs(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //For reload on button click
                        if (snapshot.connectionState == ConnectionState.done) {
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
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //List tile / Song row
                                  return SongCard(snapshot, index);
                                });
                          }
                        } else {
                          return Container(
                            child: Center(
                              child: Text("Loading..."),
                            ),
                          );
                        }
                      }))
            ])));
  }
}
