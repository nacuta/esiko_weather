import 'dart:convert' as json;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:testingbloc/Data/current.dart';

class ApiData {
  Future<CurrentWeather> getDataFromJson(String query) async {
    final _host = 'api.weatherapi.com';
    final String unencodedPath = 'v1/forecast.json';
    final String airQuality = 'no';
    final String alerts = 'no';

    Map<String, Object> params = {
      'key': token,
    };
    if (query != null && query.isNotEmpty) {
      params['q'] = query;
      params['days'] = '5';
      params['aqi'] = airQuality;
      params['alerts'] = alerts;
    }
    // fot http request
    // final url = Uri.http(_host, unencodedPath, params);
    // final results = await http.get(url);
    // if (results.statusCode == 200) {
    //   final decodedJson = json.jsonDecode(results.body);
    // var x = CurrentWeather.fromJson(decodedJson);
    // return x;
    // } else {
    //   throw ErrorDescription('No api target found');
    // }

    // for local json
    String jsonContent = await rootBundle.loadString("assets/appl.json");
    final decodedJson = json.jsonDecode(jsonContent);
    var x = CurrentWeather.fromJson(decodedJson);
    return x;
  }
}

final token = 'c292e19d7a45487ca1e194104221506';
