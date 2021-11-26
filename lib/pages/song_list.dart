import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';
import 'package:sour_notes/pages/song_details.dart';

import 'package:flutter/material.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPage createState() => _SongListPage();
}

class _SongListPage extends State<SongListPage> {
  getUrlForSongsForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/song/';
    } else {
      return 'http://localhost:8080/api/song/';
    }
  }

//Get all songs to show on page as default, so in the backend this can maybe be changed to
//just the first 10 songs if we have a lot
  Future<List<Song>> _getAllSongs() async {
    String url = getUrlForSongsForDevice() + "getAllSongs";

    var res = await http.get(Uri.parse(url));
    var body = res.body;
    print(body);
    var jsonData = json.decode(body);

    List<Song> songs = [];

    for (var s in jsonData) {
      Song song = Song(
          id: s["id"],
          deezerUrl: s["deezerUrl"],
          title: s["title"],
          artist: s["artist"],
          rating: s["averageRating"]);

      songs.add(song);
    }

    print(songs);

    return songs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text('Music'),
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
            child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder(
                  future: _getAllSongs(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                            return ListTile(
                              title: Text(snapshot.data[index].title),
                              subtitle: Text(snapshot.data[index].artist),
                              trailing: Text(snapshot.data[index].getNotes()),
                              onTap: () {
                                //When user clicks the row/tile they go to the song's detail page
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => SongDetailPage(
                                            snapshot.data[index])));
                              },
                            );
                          });
                    }
                  })),
        ])));
  }
}
