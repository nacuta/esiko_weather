import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../Data/api_data.dart';
import '../../Data/current.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    ApiData api = ApiData();
    on<FetchCityEvent>((event, emit) async {
      emit(SearchLoading(event.city));
      final apiData = await api.getDataFromJson(event.city);

      emit(SearchLoaded(apiData));
      if (apiData.error != null) {
        (emit(SearchError(apiData.error)));
      }
    });
  }
}
