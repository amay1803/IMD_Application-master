import 'package:flutter/material.dart';
import 'MyColors.dart';


class MyTextStyles {
  static const TextStyle title = TextStyle(
      fontFamily: 'OpenSans Light',
      fontSize: 45.0,
      color: MyColors.text1,
      fontWeight: FontWeight.bold);
  static const TextStyle titlewhite = TextStyle(
      fontFamily: 'OpenSans Light',
      fontSize: 30.0,
      color: MyColors.main_black,
      fontWeight: FontWeight.bold);
  static const TextStyle bodyText = TextStyle(
      fontSize: 20.0, color: MyColors.text1, fontWeight: FontWeight.bold,);
  static const TextStyle DWTHeader = TextStyle(
    fontFamily: 'OpenSans Light',
      fontSize: 20.0, color: MyColors.main_black, fontWeight: FontWeight.bold);
      static const TextStyle Weakly = TextStyle(
    fontFamily: 'OpenSans Light',
      fontSize: 30.0, color: MyColors.main_black, fontWeight: FontWeight.bold);
  static const TextStyle bodyText2 = TextStyle(color: Colors.black);
  static const TextStyle DateText = TextStyle(
      fontFamily: 'OpenSans Light',
      fontSize: 22.0,
      color: MyColors.main_black,
      fontWeight: FontWeight.bold);

  static const TextStyle DateText1 = TextStyle(
      fontSize: 22.0, color: MyColors.tp7, fontWeight: FontWeight.bold);
  static const TextStyle DateText2 = TextStyle(
      fontSize: 22.0, color: MyColors.tp8, fontWeight: FontWeight.bold);

  static const TextStyle bodyTextwhite = TextStyle(
    color: MyColors.color1,
    fontSize: 20.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );
  static const TextStyle Today = TextStyle(
    color: MyColors.forText,
    fontSize: 26.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );
  static const TextStyle WPHData = TextStyle(
      fontSize: 30.0, color: MyColors.forText, fontWeight: FontWeight.w700);
  static const TextStyle WPHText = TextStyle(
      fontSize: 23.0, color:MyColors.secondaryLightBlue, fontWeight: FontWeight.w800);

  static const TextStyle DetailHead = TextStyle(
      fontSize: 18.0, color: MyColors.forText, fontWeight: FontWeight.w800, fontFamily: 'OpenSans Light');
  static const TextStyle DetailsValue = TextStyle(
      fontSize: 20.0, color: MyColors.secondaryLightBlue, fontWeight: FontWeight.w800, fontFamily: 'OpenSans Light');

  static const TextStyle stationtext = TextStyle(
      fontSize: 12,
      color: MyColors.text1,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans Light');
       static const TextStyle observationtext = TextStyle(
      fontSize: 20,
      color: MyColors.text1,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans Light');
  static const TextStyle Whoops = TextStyle(
    color: MyColors.ohoh,
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.3,
  );
  static const TextStyle noInternetText = TextStyle(
    color: MyColors.noInternetText,
    fontSize: 18.0,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.1,
  );
}
