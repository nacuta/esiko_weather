part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {}

class SearchUninitialized extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final CurrentWeather apiResponse;
  SearchLoaded({required this.apiResponse});
  @override
  List<Object> get props => [apiResponse];
}

class SearchError extends SearchState {
  @override
  List<Object> get props => [];
}
