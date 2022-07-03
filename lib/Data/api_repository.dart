import 'package:testingbloc/Data/api_data.dart';
import 'package:testingbloc/Data/current.dart';

class ApiRepository {
  final _provider = ApiData();

  Future<CurrentWeather> getApiResponse() {
    return _provider.getDataFromJson('Arad');
  }
}

class NetworkError extends Error {}
