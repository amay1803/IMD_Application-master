import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocation/geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';
class NoConnect
{
  bool isLocationEnabled = false;
  bool internet = false;
  _checkInternet(context) async {
//    var result = await Connectivity().checkConnectivity();
//    if (result == ConnectivityResult.none) {
//      Navigator.pushNamed(context, '/nointernet').then((value){
//        internet = true;
//      });
//    } else {
//      internet = true;
//    }
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (_) {
      Navigator.pushNamed(context, '/nointernet').then((value){
        internet = true;
      });
    }
  }
  _checkGps(context) async {
//    isLocationEnabled = await Geolocator().isLocationServiceEnabled();
//    if (isLocationEnabled) {
////      await _checkInternet();
//      isLocationEnabled = true;
//    }
//    else {
//      Navigator.pushNamed(context, '/nogps').then((value) async {
////        await _checkInternet();
//        isLocationEnabled = true;
//      });
//    }
    final GeolocationResult result = await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
        ios: LocationPermissionIOS.always,
      ),
      openSettingsIfDenied: true,
    );
    print(result);
    if(result.isSuccessful) {
      isLocationEnabled = true;
    } else {
      Navigator.pushNamed(context, '/nogps').then((value) async {
        isLocationEnabled = true;
      });
    }
  }
  Future<bool> checkConnection(context) async
  {
    if(!isLocationEnabled)
      await _checkGps(context);
    print(isLocationEnabled);
    if(!internet)
        await _checkInternet(context);
    print(internet);
    if(internet && isLocationEnabled)
      return true;
    else
      return false;
  }


}