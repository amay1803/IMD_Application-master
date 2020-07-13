import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/ApiCall.dart';
import '../widgets/Animation.dart';
import 'package:connectivity/connectivity.dart';
import '../values/MyTextStyles.dart';
import '../values/MyColors.dart';

class LocationDetails extends StatefulWidget {
  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  bool flag = false;
  bool internet = true;
  ForecastMain forecast = new ForecastMain();

  _checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        internet = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments;
    final String location = data['location'];

    Widget grid() {
      return ListView.builder(
          itemCount: forecast.regions.length,
          itemBuilder: (context, index) {
            return FadeAnimation(
              delay: 1.0,
              child: Card(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/region', arguments: {
                      'days': forecast.forecasts[index],
                      'region': forecast.regions[index]
                    });
                  },
                  child: ListTile(
                      title: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.width * 0.01,
                    ),
                    child: Text(
                      '${forecast.regions[index]}',
                      style: MyTextStyles.bodyText,
                    ),
                  )),
                ),
                color: Color(0xffabc6e5), //[200 + (index * 100)]
              ),
            );
          });
    }

    void fetch() async {
      await _checkInternet();
      if (internet) {
        await forecast.getForecast(location);
        setState(() {
          flag = true;
        });
      }
    }

    Widget spinner() {
      fetch();
      return SpinKitCircle(
        color: MyColors.main_black,
        size: MediaQuery.of(context).size.width * 0.1,
      );
    }

    Widget mainScreen() {
      return flag ? grid() : spinner();
    }

    //_checkInternet();
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Image(
        image: AssetImage('assets/images/morning/day-3.jpg'),
        fit: BoxFit.cover,
      ),
      Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1,
          top: MediaQuery.of(context).size.width * 0.1,
          bottom: MediaQuery.of(context).size.width * 0.1,
        ),
        child: Text(
          'Mumbai',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans Light',
              fontSize: MediaQuery.of(context).size.height * 0.08,
              letterSpacing: MediaQuery.of(context).size.height * 0.0),
        ),
      ),
      Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.width * 0.3,
          ),
          child: internet
              ? mainScreen()
              : Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Feather.wifi_off,
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Text("No Internet", style: MyTextStyles.bodyText),
                  ],
                )))
    ]));
  }
}
