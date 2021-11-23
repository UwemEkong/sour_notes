import 'package:flutter/material.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPage createState() => _SongListPage();
}

class _SongListPage extends State<SongListPage> {
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
            child: Table(
              defaultColumnWidth: FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: [
                    Text('Title', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: [
                    Text('Artist', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: [
                    Text('Rating', style: TextStyle(fontSize: 20.0))
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [Text('The Power of Love')]),
                  Column(children: [Text('Celine Dion')]),
                  Column(children: [Text('**')]),
                ]),
                TableRow(children: [
                  Column(children: [Text('To Love You More')]),
                  Column(children: [Text('Celine Dion')]),
                  Column(children: [Text('****')]),
                ]),
                TableRow(children: [
                  Column(children: [Text('My Heart Will Go On')]),
                  Column(children: [Text('Celine Dion')]),
                  Column(children: [Text('*****')]),
                ]),
              ],
            ),
          ),
        ])));
  }
}
