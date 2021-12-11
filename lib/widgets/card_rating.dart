import 'package:flutter/material.dart';

const Color myColor = Color(0xFFAFAFF2);

class CardRating extends StatelessWidget {
  int numNotes = 0;

  CardRating(int numNotes) {
    this.numNotes = numNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Icon(Icons.music_note, color: Colors.deepOrange[600], size: 30));
  }
}
