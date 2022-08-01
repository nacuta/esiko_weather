part of 'weather_cubit.dart';

@immutable
class WeatherState extends Equatable {
  final int temperatureUnits;

  const WeatherState({
    this.temperatureUnits = 1, //TemperatureUnits.celsius,
  });

  WeatherState copyWith({
    int? temperatureUnits,
  }) {
    return WeatherState(
      temperatureUnits: temperatureUnits ?? this.temperatureUnits,
    );
  }

  @override
  List<Object?> get props => [temperatureUnits];
}

// class WeatherCelsius extends WeatherState {
//   @override
//   List<Object?> get props => [];
// }

// class WeatherFarenheit extends WeatherState {
//   @override
//   List<Object?> get props => [];
// }

enum TemperatureUnits { fahrenheit, celsius }

// extension TemperatureUnitsX on TemperatureUnits {
//   bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
//   bool get isCelsius => this == TemperatureUnits.celsius;
// }

enum WeatherStatus { initial, loading, success, failure }

extension WeatherStatusX on WeatherStatus {
  bool get isInitial => this == WeatherStatus.initial;
  bool get isLoading => this == WeatherStatus.loading;
  bool get isSuccess => this == WeatherStatus.success;
  bool get isFailure => this == WeatherStatus.failure;
}
