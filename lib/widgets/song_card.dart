import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SongCard extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  SongCard(this.snapshot, this.index, {Key? key}) : super(key: key);

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      FutureBuilder(
          future: widget.snapshot.data[widget.index]
              .getCoverArt()
              .then((String result) {
            print(result);
            return result;
          }),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // If JSON data has not arrived yet show loading
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading Image..."),
                ),
              );
            } else {
              //Once the JSON Data has arrived build the list
              return Image.network(
                snapshot.data.toString(),
              );
            }
          }),
      Text(widget.snapshot.data[widget.index].title,
          style: TextStyle(
              fontFamily: "Trajan Pro",
              height: 1.0,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
      IconButton(
        icon: isPlaying
            ? Icon(Icons.pause, color: Colors.white)
            : Icon(Icons.play_arrow, color: Colors.white),
        onPressed: () => playAudio(widget.snapshot.data[widget.index]),
      ),
    ]);
  }

  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  playAudio(data) async {
    isPlaying = !isPlaying;
    setState(() {});
    Type type = data.runtimeType;
    var duration = await player.setUrl(await data.getAudio());
    await player.setVolume(10);
    if (player.playing) {
      player.stop();
    } else {
      player.play();
    }
  }
}
