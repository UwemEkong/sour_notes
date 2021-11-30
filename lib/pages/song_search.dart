import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';
import 'package:sour_notes/pages/song_details.dart';

import 'package:flutter/material.dart';

class SongSearchPage extends StatefulWidget {
  @override
  _SongSearchPage createState() => _SongSearchPage();
}

class _SongSearchPage extends State<SongSearchPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  getUrlForSongsForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/song/';
    } else {
      return 'http://localhost:8080/api/song/';
    }
  }

  rebuildSearchResultsList() {
    _getSearchedSongs(searchController.text);
  }

  Future<List<Song>> _getSearchedSongs(text) async {
    String url = getUrlForSongsForDevice() + "searchSongs";

    var res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'rating': '5',
        'deezerUrl': text,
        'artist': text,
        'title': text,
        'id': '0'
      }),
    );
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
    // setState();

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
          Column(children: <Widget>[
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                  hintText: 'Search by Song Title'),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: Text('Search'),
                onPressed: () {
                  _getSearchedSongs(searchController.text);
                  setState(() {});
                })
          ]),
          Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder(
                  future: _getSearchedSongs(searchController.text),
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
                        print("snapshot.connectionState");
                        print(snapshot.connectionState);
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
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Loading..."),
                        ),
                      );
                    }
                  })),
        ])));
  }
}
