import 'package:flutter/material.dart';
import 'screens/HomePage.dart';
import 'screens/Launcher.dart';
import 'screens/Station.dart';
import 'screens/LocationDetails.dart';
import 'screens/Warnings.dart';
//import 'screens/loading.dart';
import 'values/MyColors.dart';
import 'screens/Region.dart';
import 'screens/Stations_data.dart';
import 'screens/NoGps.dart';
import 'screens/NoInternet.dart';
import 'screens/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IMD Weather",
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.main_bg_color,
          fontFamily: 'Bangers Light',
          textTheme: TextTheme(
              title: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              body2: TextStyle(
                fontFamily: 'Bangers',
                color: MyColors.color2,
                fontSize: 15.0,
              ))),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Launcher(),
        '/home': (context) => HomePage(),
        '/location': (context) => LocationDetails(),
        '/region': (context) => Region(),
        '/station': (context) => Station(),
        '/warnings': (context) => Warnings(),
        '/stations_data':(context) => Stations(),
        '/loading': (context) => Loading(),
        '/nointernet': (context) => NoInternet(),
        '/nogps': (context) => NoGps(),
      },
    );
  }
}
