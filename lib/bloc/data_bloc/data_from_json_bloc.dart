import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../../Data/api_repository.dart';
import '../../Data/current.dart';
import 'package:flutter/foundation.dart';
// import 'package:testingbloc/Data/current.dart';

part 'data_from_json_event.dart';
part 'data_from_json_state.dart';

class DataFromJsonBloc extends Bloc<DataFromJsonEvent, DataFromJsonState> {
  DataFromJsonBloc() : super(DataFromJsonInitial()) {
    final ApiRepository api = ApiRepository();

    //first we make the call to server to get the data
    on<GetListFromJson>((event, emit) async {
      try {
        emit(DataFromJsonLoading(event.city));
        final apiData = await api.getApiResponse(event.city);
        if (apiData.error != null) {
          emit(DataFromJsonEror(apiData.error));
        }
        emit(DataFromJsonLoaded(apiData));
      } on NetworkError {
        emit(DataFromJsonEror(
            'Faild to fetch data, check if your device is online!'));
      }
    });
  }
}
