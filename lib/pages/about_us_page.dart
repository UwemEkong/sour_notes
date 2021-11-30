// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sour_notes/models/profile.dart';
import 'package:sour_notes/pages/profile_page.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPage createState() => _AboutUsPage();
}

class _AboutUsPage extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF303030),
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Color(0xFF303030),
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
                        color: Colors.deepOrangeAccent[400])),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text('Developers:',
                    style: TextStyle(
                        height: 1.25,
                        fontSize: 20,
                        color: Colors.deepOrangeAccent[400])),
              ),
              ElevatedButton(
                child: Text('Adam Chaplin'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                          profile: Profile(
                              'assets/adam1.jpg',
                              'Hello, my name is Adam! I am the COO and temporary floor sweeper of SourNotes.',
                              '3005',
                              'Childish Gambino',
                              '(957) 247 - 1214',
                              'chaplinadam@yahoo.com',
                              'Adam Chaplin')),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Gurkirat Gill'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        profile: Profile(
                            'assets/gurkirat1.jpg',
                            'Hello, my name is Gurkirat! I am the CFO and temporary window washer of SourNotes.',
                            'Lose Yourself',
                            'Eminem',
                            '(805) 629 - 4759',
                            'gillgurkirat@yahoo.com',
                            'Gurkirat Gill'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Niraj Patel'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        profile: Profile(
                            'assets/niraj1.jpg',
                            'Hello, my name is Niraj! I am the CMO and temporary dish washer of SourNotes.',
                            'Never Gonna Give You Up',
                            'Rick Astley',
                            '(309) 438 - 8945',
                            'patelniraj@yahoo.com',
                            'Niraj Patel'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Uwem Ekong'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        profile: Profile(
                            'assets/uwem1.jpg',
                            'Hello, my name is Uwem! I am the CIO and temporary table cleaner of SourNotes.',
                            'Runaway',
                            'Kanye West',
                            '(492) 871 - 2937',
                            'ekonguwem@yahoo.com',
                            'Uwem Ekong'),
                      ),
                    ),
                  );
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
                child: Text('Dr. Mirsky'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        profile: Profile(
                            'assets/mirsky1.jpg',
                            'Hello, my name is Dr. Mirsky! I am the owner of Sour Notes. I love Star Wars.',
                            'The Imperial March',
                            'John Williams',
                            '(309) 438 - 8945',
                            'mirskydr@yahoo.com',
                            'Dr. Mirsky'),
                      ),
                    ),
                  );
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
