import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/music.dart';
import 'dart:io' show Platform;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';

import '../models/review.dart';
import '../widgets/form_input.dart';

class MusicDetailPage extends StatelessWidget {
  bool isVisible = true;
  final Music music;
  var rating = 0;

  MusicDetailPage(this.music);
  final postController = TextEditingController();

  getUrlForReviewsForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/review/';
    } else {
      return 'http://localhost:8080/api/review/';
    }
  }

  createPost(String post) async {}

//Get all songs to show on page as default, so in the backend this can maybe be changed to
//just the first 10 songs if we have a lot
  Future<List<Review>> _getAllReviews() async {
    String url = getUrlForReviewsForDevice() +
        "getAllReviewsForSong/" +
        "${this.music.id}/";
    print("URL");
    print(url);
    print(this.music.id);
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
        title: Text(music.title),
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
                    FutureBuilder(
                        future: this.music.getCoverArt(),
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
                        text: this.music.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                              text: '\n' + this.music.artist,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Colors.black)),
                          TextSpan(
                              text: '\n\n' + this.music.getNotes(),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                  ])),
              Text(
                'Rate and Write a Review!',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  allowHalfRating: false,
                  ratingWidget: RatingWidget(
                      full: Icon(Icons.music_note, color: Colors.white),
                      empty: Icon(
                        Icons.music_note_outlined,
                        color: Colors.white,
                      )),
                  onRatingUpdate: (value) {
                    rating = value.toInt();
                  }),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: postController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Write a review...',
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'Write a review..',
                        hintStyle: TextStyle(color: Colors.white)),
                  )),
              ElevatedButton(
                  child: Text('Submit Review and Rating'), onPressed: () {}),
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
              FormInput(
                  postController, 'Write a review...', 'Write a review...'),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  child: Text('Post'),
                  onPressed: () => createPost(
                        postController.text,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

// }
