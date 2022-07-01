import 'package:flutter/material.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:testingbloc/Data/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final apiData = ApiData();
  late final Future<CurrentWeather> apiResponse;

  @override
  void initState() {
    super.initState();
    apiResponse = apiData.getDataFromJson('Arad');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CurrentWeather>(
        future: apiResponse,
        builder: ((context, snapshot) {
          var futureApiData = snapshot.data;
          if (futureApiData != null) {
            return Center(
              child: Text(
                ''' ${futureApiData.current.cloud}
                ${futureApiData.current.tempC}''',
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
