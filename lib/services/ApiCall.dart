import 'package:http/http.dart';
import 'dart:convert';

class ForecastMain {
  List data;
  List regions;
  List forecasts;
  Future<void> getForecast(location) async {
    print('Fetching');
    String url = 'https://imd-weather.herokuapp.com/api/v1/' + location;
    Response response = await get(url);
    Map result = jsonDecode(response.body);
    data = result['data'];
    print(data);
    regions = List(data.length);
    forecasts = List(data.length);
    for (var i = 0; i < data.length; i++) {
      regions[i] = data[i]['location'].substring(7);
      forecasts[i] = data[i]['forecast'];
    }
  }
}

class Forecast {
  Map data;
  List forecasts;
  Future<void> getForecast(id) async {
    print('Fetching');
    String url = 'https://imd-weather.herokuapp.com/api/v1/city?cityId=' + id;
    Response response = await get(url);
    Map result = jsonDecode(response.body);
    data = result['data'];
    forecasts = data['forecast'];
    // print(data);
  }
}

class CityData {
  List data;
  Map<String, String> id;
  List city;
  Future<void> getIDs() async {
    print('Fetching IDs');
    String url = 'https://imd-weather.herokuapp.com/api/v1/mapping';
    Response response = await get(url);
    Map result = jsonDecode(response.body);
    data = result['data'];
    id = Map<String, String>();
    city = List();
    for (var i = 0; i < data.length; i++) {
      var state = data[i]['stateName'];
      if (state == 'Maharashtra' || state == 'Gujarat' || state == 'Goa') {
        city.add(data[i]['cityName']);
        id[data[i]['cityName']] = data[i]['id'];
      } else
        continue;
    }
  }
}

class PDFData {
  String regionURL;
  String districtURL;
  Future<void> getURLs() async {
    print("getting Urls");
    String url = 'https://imd-weather.herokuapp.com/api/v1/';
    for (var i = 0; i < 2; i++) {
      url = i == 0
          ? url + 'regional-forecast'
          : url.replaceAll('regional', 'district');
      Response response = await get(url);
      Map result = jsonDecode(response.body);
      i == 0 ? regionURL = result['data'] : districtURL = result['data'];
    }
    //print(regionURL + '\n' + districtURL);
  }
}
