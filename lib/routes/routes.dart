import 'package:flutter/material.dart';
import 'package:sour_notes/pages/profiles/adam_page.dart';
import 'package:sour_notes/pages/profiles/gurkirat_page.dart';
import 'package:sour_notes/pages/profiles/niraj_page.dart';
import 'package:sour_notes/pages/profiles/uwem_page.dart';
import 'package:sour_notes/pages/profiles/mirsky_page.dart';

import 'package:sour_notes/pages/home_page.dart';
import 'package:sour_notes/pages/about_us_page.dart';

import '../login.dart';

class RouteManager {
  static const String homePage = '/';
  static const String loginPage = '/loginPage';
  static const String aboutUsPage = '/aboutUsPage';

  static const String adamPage = '/adamPage';
  static const String gurkiratPage = '/gurkiratPage';
  static const String nirajPage = '/nirajPage';
  static const String uwemPage = '/uwemPage';
  static const String mirskyPage = '/mirskyPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => EntryRoute(),
        );

      case aboutUsPage:
        return MaterialPageRoute(
          builder: (context) => AboutUsPage(),
        );
      case adamPage:
        return MaterialPageRoute(
          builder: (context) => AdamPage(),
        );
      case gurkiratPage:
        return MaterialPageRoute(
          builder: (context) => GurkiratPage(),
        );
      case nirajPage:
        return MaterialPageRoute(
          builder: (context) => NirajPage(),
        );
      case uwemPage:
        return MaterialPageRoute(
          builder: (context) => UwemPage(),
        );
      case mirskyPage:
        return MaterialPageRoute(
          builder: (context) => MirksyPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
    }
  }
}
