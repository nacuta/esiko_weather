part of 'data_from_json_bloc.dart';

@immutable
abstract class DataFromJsonEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetListFromJson extends DataFromJsonEvent {}
