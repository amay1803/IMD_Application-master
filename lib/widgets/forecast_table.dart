import 'package:flutter/material.dart';
import 'package:imd_weather/values/MyColors.dart';
import '../values/MyTextStyles.dart';
import 'package:intl/intl.dart';

class ForecastTable extends StatelessWidget {
  final List days;
  ForecastTable({@required this.days});
  @override
  Widget build(BuildContext context) {
    var i = -1;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.04),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Center(
            child: Text('Weekly Forecast',
                style: TextStyle(
                    fontFamily: 'Bangers Light',
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                    color: MyColors.main_black,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.009,
                left: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.height * 0.01),
            child: Divider(
              height: MediaQuery.of(context).size.height * 0.0,
              color: MyColors.tp3,
              thickness: 2,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.00),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.009,
                left: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.height * 0.01),
            child: Divider(
              height: MediaQuery.of(context).size.height * 0.00,
              color: MyColors.tp3,
              thickness: 2,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Text(
                      'Date',
                      style: TextStyle(
                          fontFamily: 'Bangers Light',
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: MyColors.main_black,
                          fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      'Weather',
                      style: TextStyle(
                          fontFamily: 'Bangers Light',
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: MyColors.main_black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(width: 5.0),
                Expanded(
                    flex: 2,
                    child: FittedBox(
                        child: Text('Temperature',
                            style: TextStyle(
                                fontFamily: 'Bangers Light',
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: MyColors.main_black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start))),
              ],
            ),
          ),
          Column(
              children: days.map((index) {
            i++;
            return LimitedBox(
              maxHeight: MediaQuery.of(context).size.height * 200,
              child: Card(
                  color: MyColors.secondaryLightBlue,
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.01),
                    child: Row(
                      children: <Widget>[
                        // Text(
                        //     DateFormat.E()
                        //         .format(DateTime.now().add(Duration(days: i)))
                        //         .substring(0, 3),
                        //     style: MyTextStyles.bodyText2),
                        // SizedBox(width: 5.0),
                        Expanded(
                            child: Text(days[i]['date'],
                                style: TextStyle(
                                    fontFamily: 'Bangers Light',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    color: MyColors.main_black))),
                        Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              child: Text(days[i]['weather'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Bangers Light',
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      color: MyColors.main_black)),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                            flex: 2,
                            child: FittedBox(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.arrow_upward),
                                  Text(' ${days[i]['maxTemp']}°C',
                                      style: TextStyle(
                                          fontFamily: 'Bangers Light',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: MyColors.main_black)),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02),
                                  Icon(Icons.arrow_downward),
                                  Text(' ${days[i]['minTemp']}°C',
                                      style: TextStyle(
                                          fontFamily: 'Bangers Light',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          color: MyColors.main_black))
                                ],
                              ),
                            )),
                      ],
                    ),
                  )),
            );
          }).toList()),
          SizedBox(height: MediaQuery.of(context).size.height * 0.07),
          Text(
            'Maps',
            style: TextStyle(
                color: MyColors.tp6,
                fontFamily: 'Bangers Light',
                fontSize: MediaQuery.of(context).size.height * 0.04,
                letterSpacing: 0.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.00,
                left: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.height * 0.01),
            child: Divider(
              height: MediaQuery.of(context).size.height * 0.007,
              color: MyColors.tp6,
              thickness: 2,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.0),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.01,
                right: MediaQuery.of(context).size.height * 0.01),
            child: Divider(
                height: MediaQuery.of(context).size.height * 0.007,
                color: MyColors.tp6,
                thickness: 2),
          ),
        ],
      ),
    );
  }
}
