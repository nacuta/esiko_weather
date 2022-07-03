part of 'data_from_json_bloc.dart';

@immutable
abstract class DataFromJsonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataFromJsonInitial extends DataFromJsonState {}

class DataFromJsonLoading extends DataFromJsonState {}

class DataFromJsonLoaded extends DataFromJsonState {
  final CurrentWeather apiResponse;
  DataFromJsonLoaded(this.apiResponse);
}

class DataFromJsonEror extends DataFromJsonState {
  final String? message;
  DataFromJsonEror(this.message);
}
