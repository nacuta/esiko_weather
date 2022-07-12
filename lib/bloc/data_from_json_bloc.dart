import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testingbloc/Data/api_repository.dart';
import 'package:testingbloc/Data/current.dart';
import 'dart:convert' as json;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:testingbloc/Data/current.dart';

part 'data_from_json_event.dart';
part 'data_from_json_state.dart';

class DataFromJsonBloc extends Bloc<DataFromJsonEvent, DataFromJsonState> {
  DataFromJsonBloc() : super(DataFromJsonInitial()) {
    final ApiRepository _apirepository = ApiRepository();

    //first we make the call to server to get the data
    on<GetListFromJson>((event, emit) async {
      try {
        emit(DataFromJsonLoading(event.city));
        final apiData = await getApiResponse(event.city);
        emit(DataFromJsonLoaded(apiData));
        if (apiData.error != null) {
          emit(DataFromJsonEror(apiData.error));
        }
      } on NetworkError {
        emit(DataFromJsonEror(
            'Faild to fetch data, check if your device is online!'));
      }
    });
  }

  getApiResponse(String? query) async {
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
    //      return CurrentWeather.withError("Data not found / Connection issue");

    // }

    try {
      // for local json
      String jsonContent = await rootBundle.loadString("assets/appl.json");
      final decodedJson = json.jsonDecode(jsonContent);
      var x = CurrentWeather.fromJson(decodedJson);
      return x;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CurrentWeather.withError("Data not found / Connection issue");
    }
  }
}

final token = 'c292e19d7a45487ca1e194104221506';
