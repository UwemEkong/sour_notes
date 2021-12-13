import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/music.dart';
import 'package:sour_notes/pages/music_details.dart';

import 'package:flutter/material.dart';

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPage createState() => _MusicListPage();
}

class _MusicListPage extends State<MusicListPage> {
  bool highlight = false;
  String sortBy = "rating";

  getUrlForMusicForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/music/';
    } else {
      return 'http://localhost:8080/api/music/';
    }
  }

  sortByRating() {
    setState(() {
      highlight = !highlight;
      sortBy = "rating";
    });
  }

  sortByPop() {
    setState(() {
      highlight = !highlight;
      sortBy = "popularity";
    });
  }

// variable used to hold filter value, to show all items, just songs, or just albums
  String displayfilter = "all";

//Get all songs to show on page as default, so in the backend this can maybe be changed to
//just the first 10 songs if we have a lot
  Future<List<Music>> _getAllMusic(String filter) async {
    String url = getUrlForMusicForDevice() + "getAllMusic/" + sortBy;

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

      //filter

      print("music.isSong = ${music.isSong}");
      print("!music.isSong = ${!music.isSong}");

      print("filter = ${filter}");

      if (music.isSong && (filter == "songs" || filter == "all")) {
        musicList.add(music);
      }

      if (!music.isSong && (filter == "albums" || filter == "all")) {
        musicList.add(music);
      }
    }

    print(musicList);

    return musicList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF303030),
        appBar: AppBar(
          title: Text('Music', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF303030),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Column(children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          child: Text('Songs'),
                          onPressed: () {
                            this.displayfilter = "songs";
                            setState(() {});
                          })),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          child: Text('Albums'),
                          onPressed: () {
                            this.displayfilter = "albums";
                            setState(() {});
                          })),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red)),
                          child: Text('All'),
                          onPressed: () {
                            this.displayfilter = "all";
                            setState(() {});
                          }))
                ],
              ),
            ),
            ListTile(
              leading: Wrap(
                spacing: 12, // space between two icons
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () => sortByRating(),
                    label: Text("Sort by rating",
                        style: TextStyle(
                            color: highlight ? Colors.white : Colors.red,
                            fontSize: 16.0)),
                    icon: Icon(Icons.sort,
                        color: highlight ? Colors.white : Colors.red),
                  ),
                  TextButton.icon(
                    onPressed: () => sortByPop(),
                    label: Text("Sort by popularity",
                        style: TextStyle(
                            color: highlight ? Colors.red : Colors.white,
                            fontSize: 16.0)),
                    icon: Icon(Icons.sort,
                        color: highlight ? Colors.red : Colors.white),
                  ),
                ],
              ),
            ),
          ]),
          Container(
              margin: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: _getAllMusic(this.displayfilter),
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
                            physics: const PageScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              //List tile / Song row
                              return ListTile(
                                tileColor: Colors.white,
                                title: Text(snapshot.data[index].title,
                                    style: TextStyle(
                                        fontFamily: "Trajan Pro",
                                        height: 1.0,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF303030))),
                                subtitle: Text(snapshot.data[index].artist,
                                    style: TextStyle(
                                        fontFamily: "Trajan Pro",
                                        height: 1.0,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF303030))),
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
        ]))));
  }
}
