import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sour_notes/widgets/card_rating.dart';
import 'package:sour_notes/widgets/custom_text.dart';

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
    return Card(
        color: Colors.orangeAccent,
        child: Column(children: <Widget>[
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
                    child: const Center(
                      child: Text("Loading Image..."),
                    ),
                  );
                } else {
                  //Once the JSON Data has arrived build the list
                  return Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Image.network(
                        snapshot.data.toString(),
                      ));
                }
              }),
          CustomText(widget.snapshot.data[widget.index].title),
          CustomText(widget.snapshot.data[widget.index].artist),
          SizedBox(
              height: 10,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.snapshot.data[widget.index].rating,
                  itemBuilder: (BuildContext context, int index) {
                    return CardRating(
                        widget.snapshot.data[widget.index].rating);
                  })),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: IconButton(
              icon: isPlaying
                  ? Icon(Icons.pause, color: Colors.blue, size: 40.0)
                  : Icon(Icons.play_arrow, color: Colors.blue, size: 40.0),
              onPressed: () => playAudio(widget.snapshot.data[widget.index]),
            ),
          ),
        ]));
  }

  bool isPlaying = false;
  AudioPlayer player = AudioPlayer();
  playAudio(data) async {
    isPlaying = !isPlaying;
    setState(() {});
    Type type = data.runtimeType;
    var duration = await player.setUrl(await data.getAudio());
    await player.setVolume(5);
    if (player.playing) {
      player.stop();
    } else {
      player.play();
    }
  }
}
