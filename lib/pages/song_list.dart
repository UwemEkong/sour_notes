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
    String url = /*getUrlForDevice()*/ "http://localhost:8080/api/song/" +
        "getAllSongs";

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

// START BUILDING HERE

  //Future<List<Song>> _getSongList() {}

  // TableRow newSongTableRow(String title, String artist, int rating) {
  //   String notes = "🎵" * rating;

  //   return TableRow(children: [
  //     Column(children: [Text(title)]),
  //     Column(children: [Text(artist)]),
  //     Column(children: [Text(notes)]),
  //   ]);
  // }

  // List<TableRow> getSongRowsToDisplay(List songsFromBackend) {
  //   //Start with column headings
  //   List<TableRow> songRows = [
  //     TableRow(children: [
  //       Column(children: [Text('Title', style: TextStyle(fontSize: 20.0))]),
  //       Column(children: [Text('Artist', style: TextStyle(fontSize: 20.0))]),
  //       Column(children: [Text('Rating', style: TextStyle(fontSize: 20.0))]),
  //     ]),
  //   ];

  //   for (var i = 0; i < songsFromBackend.length; i++) {
  //     songRows.add(newSongTableRow(songsFromBackend[i].title,
  //         songsFromBackend[i].artist, songsFromBackend[i].rating));
  //   }

  //   return songRows;
  // }

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
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(snapshot.data[index].title),
                              subtitle: Text(snapshot.data[index].artist),
                              trailing: Text(snapshot.data[index].getNotes()),
                              onTap: () {
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.greenAccent,
  //       appBar: AppBar(
  //         title: Text('Music'),
  //         backgroundColor: Colors.greenAccent,
  //       ),
  //       body: Center(
  //           child: Column(children: <Widget>[
  //         Container(
  //           margin: EdgeInsets.all(20),
  //           child: Table(
  //             defaultColumnWidth: FixedColumnWidth(120.0),
  //             border: TableBorder.all(
  //                 color: Colors.black, style: BorderStyle.solid, width: 2),
  //             children: [],
  //           ),
  //         ),
  //       ])));
  // }
}
