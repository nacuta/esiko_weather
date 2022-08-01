import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../Data/current.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(const WeatherState());
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
