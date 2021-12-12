import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sour_notes/models/review.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show HttpClientResponse, Platform;

const Color myColor = Color(0xFFAFAFF2);

class ReviewTile extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  final bool admin;

  ReviewTile(this.snapshot, this.index, this.admin);

  @override
  State<ReviewTile> createState() => _ReviewTileState();
}

class _ReviewTileState extends State<ReviewTile> {
  bool hasLiked = false;
  bool hasDisliked = false;
  updateFavorites(int updatedFavorites, Review review) async {
    final response = await http.put(
      Uri.parse(getUrlReviewForDevice()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': review.id.toString(),
        'userId': review.userId.toString(),
        'content': review.content,
        'rating': review.rating.toString(),
        'musicId': review.musicId.toString(),
        'favorites': updatedFavorites.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print("HELLO WORLD");
      widget.snapshot.data[widget.index].favorites = updatedFavorites;
      checkHasFavorited(widget.snapshot.data[widget.index].id);
      setState(() {});
    } else {
      print(response.body);
    }
  }

  String getUrlReviewForDevice() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/review/updateFavorites';
    } else {
      return 'http://localhost:8080/api/review/updateFavorites';
    }
  }

  String getUrlFavoriteForDevice(int reviewId) {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/favorite/getFavorite/$reviewId';
    } else {
      return 'http://localhost:8080/api/favorite/getFavorite/$reviewId';
    }
  }

  checkHasFavorited(int reviewId) async {
    String url = getUrlFavoriteForDevice(reviewId);
    var res = await http.get(Uri.parse(url));
    var body = res.body;
    var jsonData = json.decode(body);
    if (body != "" && jsonData['type'] == 'like') {
      hasLiked = true;
      hasDisliked = false;
      setState(() {});
    } else if (body != "" && jsonData['type'] == 'dislike') {
      hasDisliked = true;
      hasLiked = false;
      setState(() {});
    }
  }

  void initState() {
    checkHasFavorited(widget.snapshot.data[widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
            child: Column(children: <Widget>[
          ListTile(
            title: Text(widget.snapshot.data[widget.index].content,
                style: TextStyle(fontSize: 22)),
            subtitle: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: "Favorites: ",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                  TextSpan(
                      text: widget.snapshot.data[widget.index].favorites
                          .toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            trailing: Wrap(spacing: 5, children: <Widget>[
              Text(widget.snapshot.data[widget.index].getNotes()),
              if (widget.admin)
                IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      debugPrint('ready to delete');
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            //List tile / Song row
                            return ListTile(
                                title: Text(''),
                                subtitle: Text(''),
                                trailing: Text(''));
                          });
                    })
            ]),
          ),
          Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Wrap(
                  spacing: 2, // space between two icons
                  children: <Widget>[
                    IconButton(
                      icon: hasLiked
                          ? Icon(Icons.thumb_up, color: Colors.orange)
                          : Icon(Icons.thumb_up_outlined),
                      onPressed: () => updateFavorites(
                          widget.snapshot.data[widget.index].favorites + 1,
                          widget.snapshot.data[widget.index]),
                    ), // icon-1
                    IconButton(
                      icon: hasDisliked
                          ? Icon(Icons.thumb_down, color: Colors.orange)
                          : Icon(Icons.thumb_down_outlined),
                      onPressed: () => updateFavorites(
                          widget.snapshot.data[widget.index].favorites - 1,
                          widget.snapshot.data[widget.index]),
                    ), // icon-2
                  ],
                )),
          ]),
        ])));
  }
}
