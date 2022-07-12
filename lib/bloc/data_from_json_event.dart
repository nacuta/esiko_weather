part of 'data_from_json_bloc.dart';

@immutable
abstract class DataFromJsonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListFromJson extends DataFromJsonEvent {
  final String city;

  GetListFromJson(this.city);

  @override
  List<Object?> get props => [city];
}
