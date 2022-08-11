import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testingbloc/home_page.dart';
import '../../Data/api_data.dart';
import '../../Data/api_repository.dart';
import '../../Data/current.dart';
import 'package:flutter/foundation.dart';
// import 'package:testingbloc/Data/current.dart';

part 'data_from_json_event.dart';
part 'data_from_json_state.dart';

class DataFromJsonBloc
    extends HydratedBloc<DataFromJsonEvent, DataFromJsonState> {
  DataFromJsonBloc() : super(DataFromJsonInitial()) {
    final ApiRepository api = ApiRepository();

    //first we make the call to server to get the data
    on<GetListFromJsonEvent>((event, emit) async {
      try {
        final apiData = await api.getApiResponse(event.city);
        emit(DataFromJsonLoading());

        if (apiData.error != null) {
          emit(DataFromJsonEror(apiData.error));
        }
        emit(
          DataFromJsonLoaded(
            apiResponse: apiData,
          ),
        );
      } on NetworkError {
        emit(DataFromJsonEror(
            'Faild to fetch data, check if your device is online!'));
      }
    });
  }

  @override
  DataFromJsonState? fromJson(Map<String, dynamic> json) {
    try {
      final data = CurrentWeather.fromJson(json);
      return DataFromJsonLoaded(apiResponse: data);
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(DataFromJsonState state) {
    if (state is DataFromJsonLoaded) {
      return state.apiResponse.toJson();
    } else {
      return null;
    }
  }
}
