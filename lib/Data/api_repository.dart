import 'package:testingbloc/Data/api_data.dart';
import '../Data/current.dart';

class ApiRepository {
  final ApiData _provider = ApiData();

  Future<CurrentWeather> getApiResponse(String query) {
    return _provider.getDataFromJson(query);
  }
}

class NetworkError extends Error {}
