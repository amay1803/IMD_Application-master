import 'package:flutter/material.dart';
import 'package:imd_weather/screens/loading.dart';
import '../services/ApiCall.dart';
import '../values/MyTextStyles.dart';
import 'package:imd_weather/values/MyColors.dart';
import 'package:geolocator/geolocator.dart';

class SearchBar extends SearchDelegate<String> {
  static List cities = [];
  static Map id = {};
   String text = "Enter city name";
  
  @override
 
  String get searchFieldLabel => text;

  static getCities() async {
    CityData cityData = new CityData();
    await cityData.getIDs();
    cities = cityData.city;
    id = cityData.id;
  }

  List recentcities = cities;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: Color(0xff00708b),
        primaryIconTheme: theme.primaryIconTheme,
        primaryColorBrightness: theme.primaryColorBrightness,
        inputDecorationTheme:
            InputDecorationTheme(hintStyle: MyTextStyles.bodyTextwhite));
  }
// flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors: [Color(0x00008b), Color(0xffB1ADE2)])),
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var suggestionList;
    bool flag = true;
    String msg;
    if (query.isEmpty) {
      flag = false;
      msg = "Search for cities in Maharashtra,Goa,Gujarat";
    } else {
      if (cities.isNotEmpty) {
        suggestionList = cities
            .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
        if (suggestionList.isEmpty) {
          flag = false;
          msg = "No Results \n Try searching a Major City";
        }
      } else {
        flag = false;
        msg = "No Internet :(";
      }
    }
    //print('from searchbar');

    return flag
        ? ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () async {
                print('tapped ${suggestionList[index]}');
                await Future.delayed(Duration(milliseconds: 500));
                String location = suggestionList[index].toString();
                location =
                    location.contains('-') ? location.substring(location.indexOf('-')+1) : location;

                var latitude = 0.0;
                var longitude = 0.0;
//var cmplist=["Anni", "Diu", "Keylong", "Bagh","Gund","Kharmang", "Nagar", "Nilam","Agati","Pali","Siker"," Gyalsingh", "Tondi", "Harsil", "Sri Hemkunt Sahib"];
                //var cmplatlist=[31.4335,20.7144,32.5710,22.3583,34.2590,0.00000,19.0948,17.6464,0.0000,25.7781,27.6094,27.2950,9.7438,31.0383,30.699286];
                //var cmplonglist=[77.4171,70.9874,77.0320,74.7908,75.0889,0.0000,74.7480,75.9391,0.0000,73.3311,75.1398,88.2534,79.0185,78.7377,79.615029];
                //Agati   kharmag
                try {
                  List<Placemark> placemark = await Geolocator()
                      .placemarkFromAddress(suggestionList[index]);
                  latitude = (placemark[0].position.latitude);
                  longitude = (placemark[0].position.longitude);
                } catch (e) {
                  // myforloop: for(var i=0;i<cmplist.length;i++){
                  //   if(location==cmplist[i]){
                  //     latitude=cmplatlist[i];
                  //     longitude=cmplonglist[i];
                  //     break myforloop;
                }

//}
//}

                close(context,null);
                Navigator.pushReplacementNamed(context, '/home', arguments: {
                  'latitude': latitude,
                  'longitude': longitude,
                  'userlocation': location,
                  "datalocation": suggestionList[index],
                  "from": 'Searchbar'
                });
                //showResults(context);
              },
              leading: Icon(Icons.location_city, color: Colors.blue),
            
              title: RichText(
                text: TextSpan(
                    text: suggestionList[index].substring(0, query.length),
                    style: TextStyle(
                        fontFamily: 'OpenSans Light',
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: suggestionList[index].substring(query.length),
                          style: TextStyle(
                            color: Colors.grey,
                          ))
                    ]),
                // title: Text("hello"),
              ),
            ),
            itemCount: suggestionList.length,
          )
        : Center(
            child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      msg,
                      style: MyTextStyles.bodyText,
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ],
            ),
          ));
  }
}

// [Anni, Airport, Airport, City, Mana, Ridge, Diu, Airport, Ambli, Pirana,  Airport, City, Keylong, Airport, City, Bagh, Gund, Airport, City, Kharmang, Nagar, Nilam, Airport, City, City, International Airport,  Airport, City, Agati, Airport, Santacruz, College of Agriculture, Airport, Pali, Siker, Gyalsingh, Tondi, Airport, Control Room, Asharori, Harsil, Sri Hemkunt Sahib, Dum Dum]
//[Anni, Diu, Keylong, Bagh, Gund, Kharmang, Nagar, Nilam, Agati, Pali, Siker, Gyalsingh, Tondi, Harsil, Sri Hemkunt Sahib]
