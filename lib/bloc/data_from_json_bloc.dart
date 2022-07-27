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
// import 'package:testingbloc/Data/current.dart';

part 'data_from_json_event.dart';
part 'data_from_json_state.dart';

class DataFromJsonBloc extends Bloc<DataFromJsonEvent, DataFromJsonState> {
  DataFromJsonBloc() : super(DataFromJsonInitial()) {
    final ApiRepository api = ApiRepository();

    //first we make the call to server to get the data
    on<GetListFromJson>((event, emit) async {
      try {
        emit(DataFromJsonLoading(event.city));
        final apiData = await api.getApiResponse(event.city);
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
}
