import 'package:flutter/material.dart';
import 'package:imd_weather/values/MyColors.dart';
import 'package:imd_weather/values/MyTextStyles.dart';
import '../widgets/forecast_table.dart';

class Region extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final List days = data['days'];
    final String region = data['region'];
    return Scaffold(
   
      backgroundColor: MyColors.main_bg_color,
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.width*0.1),
          Text(region, style: MyTextStyles.titlewhite),
          SizedBox(height: MediaQuery.of(context).size.width*0.0),
          ForecastTable(days: days),
        ],
      ),
    );
  }
}
