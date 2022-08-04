part of 'data_from_json_bloc.dart';

@immutable
abstract class DataFromJsonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListFromJsonEvent extends DataFromJsonEvent {
  final String city;

  GetListFromJsonEvent(this.city);

  @override
  List<Object?> get props => [city];
}

class ErrorDataFromJsonEvent extends DataFromJsonEvent {}

class DataFromJsonUpdated extends DataFromJsonEvent {
  final CurrentWeather apiData;

  DataFromJsonUpdated(this.apiData);
}
