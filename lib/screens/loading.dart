import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:imd_weather/values/MyTextStyles.dart';
import '../values/MyColors.dart';
import 'dart:math' as math;
import 'package:imd_weather/screens/NoConnnect.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  var userlat = 0.0;
  var userlong = 0.0;
  var datalocation;
  bool flag;
  int counter = 0;
  NoConnect noConnect;

  void getCurrentLocation() async {
    var Position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    userlat = Position.latitude;
    userlong = Position.longitude;

    final oldcoordinates = new Coordinates(userlat, userlong);
//    Geocoder gcd = new Geocoder(this,Locale.getDefault());
//    List<Address> addresses = Ge;
    var oldaddresses =
        await Geocoder.local.findAddressesFromCoordinates(oldcoordinates);
    var first = oldaddresses.first;
    var oldadminarea = first.adminArea;
    if (oldadminarea == 'Goa') {
      var index = distance(userlat, userlong, listgoalat, listgoalong);
      datalocation = goa[index];
    } else if (oldadminarea == 'Maharashtra') {
      var index = distance(userlat, userlong, listmahlat, listmahlong);
      datalocation = maharashtra[index];
    } else {
      var index = distance(userlat, userlong, listgujlat, listgujlong);
      datalocation = gujarat[index];
    }

    final coordinates = new Coordinates(userlat, userlong);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var Location = addresses.first;
    var userlocation = Location.locality;
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'latitude': userlat,
      'longitude': userlong,
      'datalocation': datalocation,
      'userlocation': userlocation
    });
  }

  void callingcheckingmethod(context) async {
    print("Before call");
    noConnect = new NoConnect();
    await noConnect.checkConnection(context).then((check) {
      if (check) {
        setState(() {
          flag = true;
        });
      }
    });
    print("After call");
  }

  @override
  void initState() {
    flag = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (counter == 0) {
      callingcheckingmethod(context);
    }
    counter++;
    print('Location:${noConnect.isLocationEnabled}');
    print('Internet:${noConnect.internet}');
    print('Counter:$counter');
    if (noConnect.isLocationEnabled && noConnect.internet) {
      print("Getting Location");
      getCurrentLocation();
    }
//    getCurrentLocation();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.asset('assets/images/load.gif')),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0),
            Text(
              "Loading...",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.03,
                color: MyColors.text1,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )));
    // body: Center(
    //     child: SpinKitRing(
    //   color: Colors.red,
    //   size: 80.0,
    // )));
  }
}

var goa = ["Panjim", "Panjim-Mapusa", "Panjim-Old Goa", "Panjim-Pernem"];
var listgoalat = [
  0.2703672090971896,
  0.27216140756823975,
  0.270560940644161,
  0.2743622677550046
];
var listgoalong = [
  1.2885381895038697,
  1.2883008247255985,
  1.2899728501490089,
  1.2879884107894914
];

var maharashtra = [
  "Ahmednagar",
  "Akola city",
  "Alibag",
  "Amaravati",
  "Aurangabad",
  "Beed",
  "Buldhana",
  "Chandrapur",
  "Dahanu",
  "Gondia",
  "Harnai",
  "Jalgaon",
  "Jeur",
  "Kolhapur",
  "Mahabaleshwar",
  "Malegaon",
  "Mumbai-Borivali",
  "Mumbai-Chembur",
  "Mumbai-Colaba",
  "Mumbai-Mulund",
  "Mumbai-Powai",
  "Mumbai-Santacruz",
  "Mumbai-Worli",
  "Nagpur-College of Agriculture",
  "Nagpur-Sonegaon Airport",
  "Nanded",
  "Nasik",
  "Navi Mumbai (Panvel)",
  "Osmanabad",
  "Parbhani",
  "Pune-Lohegaon Airport",
  "Pune-Pashan",
  "Pune-Shivajinagar",
  "Ratnagiri",
  "Sangli",
  "Satara",
  "Sholapur",
  "Thane",
  "Udgir",
  "Vengurla",
  "Wardha",
  "Yeotmal"
];
var listmahlat = [
  0.33326713000981323,
  0.3612866458213302,
  0.32565051315411,
  0.36533231902745306,
  0.34690513278489693,
  0.3314397702829752,
  0.3583021328004199,
  0.3483938986368481,
  0.3488965534614225,
  0.3744586456861314,
  0.5254208993373809,
  0.36665353327121275,
  0.3187006120726686,
  0.2915572515456527,
  0.3129497521873473,
  0.3588030422957423,
  0.33563903246327353,
  0.3325236197484636,
  0.32998416568681194,
  0.3346249961678648,
  0.33366506507926796,
  0.3330838704383538,
  0.3315881232693947,
  0.369041143687941,
  0.36812135517214,
  0.3340263482344308,
  0.34902221716756604,
  0.3314275529782112,
  0.3173933604629248,
  0.3361643765681238,
  0.324561846579886,
  0.3236102232585286,
  0.3234339450040772,
  0.2965349305723406,
  0.2941298668630924,
  0.3085829383988574,
  0.3082234005729466,
  0.3354226116360262,
  0.32104109859959296,
  0.2766591210506292,
  0.36207378931397965,
  0.3558708891523918
];
var listmahlong = [
  1.3045987092807216,
  1.3440466410342973,
  1.2719488349636636,
  1.3570336359983872,
  1.3149886543178437,
  1.3221410135925165,
  1.3296651279978642,
  1.3839780289906756,
  1.2695472619129193,
  1.3996859922586244,
  1.1857330605736476,
  1.3188161613674674,
  1.311847061664254,
  1.2957900325459062,
  1.2853948515210278,
  1.300425627039203,
  1.2715892971377527,
  1.2723537513501262,
  1.2708562588519152,
  1.2730867896359637,
  1.272449744458986,
  1.2712280139825898,
  1.270903382741719,
  1.3800981620634922,
  1.3796688110675015,
  1.3495060309345355,
  1.2878749643881118,
  1.276141115826954,
  1.327183269801528,
  1.3399730425601426,
  1.2902293786424672,
  1.2879220882779157,
  1.2888314048182046,
  1.279535781222083,
  1.301692736076151,
  1.2918630417289187,
  1.324816603335824,
  1.2737081268496737,
  1.3458687647733794,
  1.2852412625468526,
  1.3718671893110868,
  1.3636379618879337
];

var gujarat = ["Panjim", "Panjim-Mapusa", "Panjim-Old Goa", "Panjim-Pernem"];
var listgujlat = [
  0.40181842704039455,
  0.4027067996296596,
  0.40200517727035795,
  0.4033298821726216,
  0.40557088493218235,
  0.4020610278064217,
  0.4029668536882068,
  0.39887754725078406,
  0.4017573405165747,
  0.4017974830893706,
  0.4019545627220501,
  0.3770172983695551,
  0.3893340869008791,
  0.3798621850503059,
  0.4056494247485221,
  0.35222315101572366,
  0.42339069659504447,
  0.49885524279277527,
  0.4160777670291882,
  0.4015670996281073,
  0.405979291977149,
  0.39208647113127415,
  0.3777189207288568,
  0.3892764910355632,
  0.3694896933057036,
  0.36505132101788196
];
var listgujlong = [
  1.266609872781813,
  1.2675732945289138,
  1.2646708119828471,
  1.266845492230832,
  1.2679415590010845,
  1.2664283585396057,
  1.2669659199492198,
  1.2667721884022483,
  1.2667791697192565,
  1.26752617063911,
  1.2656743763027438,
  1.2430304745873695,
  1.2772528905604743,
  1.2592882165696966,
  1.2159167846576375,
  1.2743853145994477,
  1.2599654043194706,
  1.344776188661631,
  1.2741008259313726,
  1.224999478085016,
  1.201263000257893,
  1.2055024050109875,
  1.2152605408588877,
  1.235731507655529,
  1.2711424928492423,
  1.2280642762515181
];

distance(userlat, userlong, listlat, listlong) {
  var index;
  var temp = 1000.0;
  var R = 3958.8;
  var ruserlat = userlat * (math.pi / 180);
  var ruserlong = userlong * (math.pi / 180);
  for (int i = 0; i < listlat.length; i++) {
    var lat = listlat[i] - ruserlat;
    var long = listlong[i] - ruserlong;
    var value1 = 2 *
        R *
        math.asin(math.sqrt(math.sin(lat / 2) * math.sin(lat / 2) +
            math.cos(ruserlat) *
                math.cos(listlat[i]) *
                math.sin(long / 2) *
                math.sin(long / 2)));
    if (temp > value1) {
      temp = value1;
      index = i;
    }
  }
  return index;
}
