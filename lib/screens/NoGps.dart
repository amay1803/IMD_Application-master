import 'package:flutter/material.dart';
import 'package:imd_weather/values/MyColors.dart';
import 'package:imd_weather/values/MyTextStyles.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class NoGps extends StatefulWidget {
  @override
  _NoGpsState createState() => _NoGpsState();
}

class _NoGpsState extends State<NoGps> {
  bool isLocationEnabled = true;
//  PermissionStatus _status;
//  void _updateStatus(PermissionStatus status)
//  {
//    if(status != _status)
//    {
//      setState(() {
//        _status = status;
//      });
//    }
//  }
//
//  void _askpermission(){
//    PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
//  }
//
//  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses){
//    final status = statuses[PermissionGroup.locationWhenInUse];
//    _updateStatus(status);
//  }

  _checkGps() async {
//   print("Check gps caaled");
//    _askpermission();
    isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if (isLocationEnabled) {
      setState(() {
        isLocationEnabled = true;
      });
      for(int i=0;i<2;i++)
      {
        print("Popping Context");
        Navigator.pop(context);
      }
      Navigator.pushNamed(context, '/loading');
    }
    else {
      setState(() {
        isLocationEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height* 0.2),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Image(
                image: AssetImage("assets/images/noconnection/compass.png"),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.0),
            Text(
              "Oh-NO!",
              style: TextStyle(
                color: MyColors.ohoh,
                fontSize: MediaQuery.of(context).size.height * 0.035,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.3,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.01),
            Center(
              child: Text(
                "You Decline our request.",
                style: TextStyle(
                  color: MyColors.noInternetText,
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                ),
              ),
            ), SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Center(
              child: Text(
                "Please enable GPS Location  ",
                style: TextStyle(
                  color: MyColors.noInternetText,
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.1,
            ),
            Container(
              width:  MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                color: MyColors.noInternetbutton,
                onPressed: ()async {
                  await Future.delayed(Duration(seconds: 1));
                  await _checkGps();
                },
                child: Text(
                  "RETRY",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:  MediaQuery.of(context).size.height * 0.03,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
