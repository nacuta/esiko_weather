import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:testingbloc/Data/api_repository.dart';
import 'package:testingbloc/Data/current.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiRepository api = ApiRepository();

  // SearchBloc(super.initialState);
  SearchBloc() : super(SearchUninitialized()) {
    on<Search>((event, emit) async {
      try {
        CurrentWeather response = await api.getApiResponse(event.city);
        emit(SearchLoaded(apiResponse: response));
      } catch (e) {
        emit(SearchError());
      }
    });
  }
}
