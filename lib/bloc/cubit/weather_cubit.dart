import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data/current.dart';

part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit() : super(const WeatherState(temperatureUnits: 1));

  @override
  WeatherState fromJson(Map<String, dynamic> json) {
    return WeatherState(temperatureUnits: json["unit"] as int);
  }

  @override
  Map<String, dynamic> toJson(WeatherState state) {
    return <String, int>{'unit': state.temperatureUnits};
  }

  void toCelsius() {
    var units = state.temperatureUnits;
    units = 1; //from Celsius
    emit(
      state.copyWith(
        temperatureUnits: units,
      ),
    );
  }

  void toFahrenheit() {
    var units = state.temperatureUnits;
    units = 2; //TemperatureUnits.fahrenheit;
    emit(
      state.copyWith(
        temperatureUnits: units,
      ),
    );
  }
}
