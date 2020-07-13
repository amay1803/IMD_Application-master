import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/ApiCall.dart';
import '../values/MyColors.dart';
import '../values/MyTextStyles.dart';
import '../widgets/forecast_table.dart';

class Station extends StatefulWidget {
  @override
  _StationState createState() => _StationState();
}

class _StationState extends State<Station> {
  bool flag = false;
  List days;
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final String location = data['location'];
    final String id = data['id'];
    Forecast forecast = new Forecast();

    void fetch() async {
      await forecast.getForecast(id);
      setState(() {
        days = forecast.forecasts;
        flag = true;
      });
    }

    Widget spinner() {
      fetch();
      return SpinKitCircle(
        color: MyColors.color2,
        size: MediaQuery.of(context).size.height*0.03,
      );
    }

    return Scaffold(
        backgroundColor: MyColors.main_bg_color,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    FittedBox(child: Text(location, style: MyTextStyles.titlewhite)),
                    SizedBox(height: 20.0),
                    Text(id, style: MyTextStyles.bodyTextwhite),
                    SizedBox(height: 20.0),
                    flag ? ForecastTable(days: days) : spinner()
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
