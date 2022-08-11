part of 'data_from_json_bloc.dart';

@immutable
abstract class DataFromJsonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataFromJsonInitial extends DataFromJsonState {}

class DataFromJsonLoading extends DataFromJsonState {
  DataFromJsonLoading();
}

class DataFromJsonLoaded extends DataFromJsonState {
  final CurrentWeather apiResponse;
  DataFromJsonLoaded({required this.apiResponse});

  Map<String, dynamic> toJson() {
    return {'apidata': apiResponse};
  }
}

class DataFromJsonEror extends DataFromJsonState {
  final String? message;
  DataFromJsonEror(this.message);
}
