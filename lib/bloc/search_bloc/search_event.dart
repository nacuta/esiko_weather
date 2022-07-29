part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class FetchCityEvent extends SearchEvent {
  final String city;

  FetchCityEvent(this.city);

  @override
  List<Object?> get props => [city];
}
