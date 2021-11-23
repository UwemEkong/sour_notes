// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/routes/routes.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                    'Hello, we here at SourNotes LOVE music! \n'
                    'We are just a bunch of kids trying to make it big with our first ever mobile app!\n\n'
                    'Our goal is to provide a platform for music enthusiasts all over the nation to share their personal music experiences with others like them. \n\n'
                    'Click on the links below to learn a little bit more about who we are as individuals! \n',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                        fontSize: 25,
                        color: Colors.red[500])),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Developers:',
                    style: TextStyle(
                        height: 1.25,
                        fontSize: 20,
                        color: Colors.blue[500])),
              ),
              ElevatedButton(
                child: Text('Adam Chaplin'),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.adamPage);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Gurkirat Gill'),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.gurkiratPage);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Niraj Patel'),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.nirajPage);
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Uwem Ekong'),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.uwemPage);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('VIP:',
                    style: TextStyle(
                        height: 1.25, fontSize: 20, color: Colors.blue[500])),
              ),
              ElevatedButton(
                child: Text('Dr. Mirksy'),
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteManager.mirskyPage);
                },
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
