import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/music.dart';
import 'package:sour_notes/pages/music_details.dart';

import 'package:flutter/material.dart';

class MusicSearchPage extends StatefulWidget {
  @override
  _MusicSearchPage createState() => _MusicSearchPage();
}

class _MusicSearchPage extends State<MusicSearchPage> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  getUrlForMusicForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/music/';
    } else {
      return 'http://localhost:8080/api/music/';
    }
  }

  rebuildSearchResultsList() {
    _getSearchedMusic(searchController.text);
  }

  Future<List<Music>> _getSearchedMusic(text) async {
    String url = getUrlForMusicForDevice() + "searchMusic";

    var res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'rating': '5',
        'deezerUrl': text,
        'isSong': 'true',
        'artist': text,
        'title': text,
        'id': '0'
      }),
    );
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

    print(musicList);
    // setState();

    return musicList;
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
                  _getSearchedMusic(searchController.text);
                  setState(() {});
                })
          ]),
          Container(
              margin: EdgeInsets.all(20),
              child: FutureBuilder(
                  future: _getSearchedMusic(searchController.text),
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
                                          builder: (context) => MusicDetailPage(
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
