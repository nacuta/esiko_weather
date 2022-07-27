part of 'search_bloc.dart';

@immutable
abstract class SearchEvent extends Equatable {}

class Search extends SearchEvent {
  String city;

  Search({required this.city});

  @override
  List<Object> get props => [city];
}
