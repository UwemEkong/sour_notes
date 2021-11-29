import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';

import 'package:flutter/material.dart';

import '../models/review.dart';

class SongDetailPage extends StatelessWidget {
  final Song song;

  SongDetailPage(this.song);

  getUrlForReviewsForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/review/';
    } else {
      return 'http://localhost:8080/api/review/';
    }
  }

//Get all songs to show on page as default, so in the backend this can maybe be changed to
//just the first 10 songs if we have a lot
  Future<List<Review>> _getAllReviews() async {
    String url = getUrlForReviewsForDevice() +
        "getAllReviewsForSong/" +
        "${this.song.id}/";
    print("URL");
    print(url);
    print(this.song.id);
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    print(body);
    var jsonData = json.decode(body);

    List<Review> reviews = [];

    for (var s in jsonData) {
      Review review = Review(
          id: s["id"],
          userId: s["userId"],
          content: s["content"],
          rating: s["rating"],
          songId: (s["songId"] == null ? (-1) : s["songId"]),
          albumId: (s["albumId"] == null ? (-1) : s["albumId"]),
          favorites: s["favorites"]);

      reviews.add(review);
    }

    print(reviews);

    return reviews;
  }

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
                  margin: EdgeInsets.all(20),
                  child: Column(children: [
                    RichText(
                        text: TextSpan(
                            text: "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black,
                            ))),
                    FutureBuilder(
                        future: _getAllReviews(),
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
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //List tile / Song row
                                  return ListTile(
                                    title: Text(snapshot.data[index].content),
                                    subtitle:
                                        Text('${snapshot.data[index].userId}'),
                                    trailing:
                                        Text(snapshot.data[index].getNotes()),
                                  );
                                });
                          }
                        })
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
