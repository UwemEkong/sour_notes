import 'package:flutter/material.dart';

const Color myColor = Color(0xFFAFAFF2);

class ReviewTile extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;
  final int index;
  final bool admin;
  ReviewTile(this.snapshot, this.index, this.admin);

  @override
  Widget build(BuildContext context) {
    // return Column(children: <Widget>[
    //   ListTile(
    //     title: Text(snapshot.data[index].content),
    //     subtitle: Text('Favorites: ' + '${snapshot.data[index].favorites}'),
    //     trailing: Wrap(spacing: 5, children: <Widget>[
    //       Text(snapshot.data[index].getNotes()),
    //       if (admin)
    //         IconButton(
    //             icon: new Icon(Icons.cancel),
    //             onPressed: () {
    //               debugPrint('ready to delete');
    //               ListView.builder(
    //                   scrollDirection: Axis.vertical,
    //                   shrinkWrap: true,
    //                   itemCount: snapshot.data.length,
    //                   itemBuilder: (BuildContext context, int index) {
    //                     //List tile / Song row
    //                     return ListTile(
    //                         title: Text(''),
    //                         subtitle: Text(''),
    //                         trailing: Text(''));
    //                   });
    //             })
    //     ]),
    //   ),
    //   Row(children: <Widget>[
    //     Wrap(
    //       spacing: 12, // space between two icons
    //       children: <Widget>[
    //         Icon(Icons.thumb_up), // icon-1
    //         Icon(Icons.thumb_down), // icon-2
    //       ],
    //     ),
    //   ]),
    // ]);
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Card(
            child: Column(children: <Widget>[
          ListTile(
            title: Text(snapshot.data[index].content,
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
                      text: snapshot.data[index].favorites.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            trailing: Wrap(spacing: 5, children: <Widget>[
              Text(snapshot.data[index].getNotes()),
              if (admin)
                IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      debugPrint('ready to delete');
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
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
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    Icon(Icons.thumb_up), // icon-1
                    Icon(Icons.thumb_down), // icon-2
                  ],
                )),
          ]),
        ])));
  }
}
