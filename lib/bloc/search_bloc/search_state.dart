part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final String city;

  SearchLoading(this.city);
}

class SearchLoaded extends SearchState {
  final CurrentWeather apiResponse;
  SearchLoaded(this.apiResponse);

  @override
  List<Object?> get props => [apiResponse];
}

class SearchError extends SearchState {
  final String? message;

  SearchError(this.message);
}
