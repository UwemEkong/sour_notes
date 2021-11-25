import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sour_notes/models/song.dart';

import 'package:flutter/material.dart';

class SongDetailPage extends StatelessWidget {
  final Song song;

  SongDetailPage(this.song);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.greenAccent,
        appBar: AppBar(
          title: Text(song.title),
          backgroundColor: Colors.greenAccent,
        ));
  }
}
