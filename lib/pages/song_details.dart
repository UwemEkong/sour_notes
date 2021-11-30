import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';
import 'dart:io' show Platform;


import 'package:flutter/material.dart';

import '../models/review.dart';

class SongDetailPage extends StatelessWidget {
  bool isVisible = true;
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

  bool admin = false;

  checkUser() async {
    var url = Platform.isAndroid
        ? 'http://10.0.2.2:8080/api/auth/getloggedinuser'
        : 'http://localhost:8080/api/auth/getloggedinuser';
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    if (body.length > 1) {
      if (json.decode(body)["username"] == "admin") {
        admin = true;
      }
      return admin;
    }
  }

  erase() {}

  @override
  Widget build(BuildContext context) {
    checkUser();
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: Text(song.title),
        backgroundColor: Color(0xFF303030),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(40),
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
                  color: Colors.white,
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
                                        Wrap(spacing: 5, children: <Widget>[
                                      Text(snapshot.data[index].getNotes()),
                                      if (admin)
                                        IconButton(
                                            icon: new Icon(Icons.cancel),
                                            onPressed: () {
                                              debugPrint('ready to delete');
                                              ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    //List tile / Song row
                                                    return ListTile(
                                                        title: Text(''),
                                                        subtitle: Text(''),
                                                        trailing: Text(''));
                                                  });
                                            })
                                    ]),
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

// }
