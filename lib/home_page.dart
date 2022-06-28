import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'current.dart';
import 'data.dart';

class HomePageInitial extends StatefulWidget {
  const HomePageInitial({super.key});

  @override
  State<HomePageInitial> createState() => _HomePageInitialState();
}

class _HomePageInitialState extends State<HomePageInitial> {
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
      appBar: AppBar(title: const Text('Initial')),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 200,
              height: 300,
              child: Stack(
                children: const [
                  Positioned(
                    top: 10,
                    child: Sun(),
                  ),
                  Positioned(
                    top: 5,
                    child: Clouds(),
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: apiResponse,
              builder: (context, snapshot) {
                var futureApiData = snapshot.data;
                if (futureApiData != null) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(100.0),
                        2: FixedColumnWidth(100.0),
                        3: FixedColumnWidth(100.0),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(7, (int index) {
                        final moonLanding = DateTime.parse(
                          futureApiData.location.localtime,
                        );
                        var dateNow = moonLanding.add(Duration(days: index));
                        var x = DateFormat('EEEE').format(dateNow);
                        print(x); // 7
                        print(dateNow); // 7
                        // Weather dailyWeather =
                        //     forecast.days[index].hourlyWeather[0];
                        // final weatherIcon = _getWeatherIcon(dailyWeather);
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(x),
                              ),
                            ),
                            TableCell(
                              child: Text(moonLanding.toString()),
                            ),
                            // TableCell(
                            //   child: Text('data'),
                            // ),
                            TableCell(
                              child: Text(futureApiData
                                  .forecast.forecastday[0].day.maxtempC
                                  .toString()),
                            ),
                          ],
                        );
                      }),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

class Clouds extends StatelessWidget {
  const Clouds({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 300,
      // height: 300,
      child: Image.asset(
        'assets/cloud.png',
        // fit: BoxFit.fitWidth,
        width: 200,
        height: 300,
      ),
    );
  }
}

class Sun extends StatelessWidget {
  const Sun({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200,
      // height: 200,
      child: Image.asset(
        'assets/sun.png',
        fit: BoxFit.fitWidth,
        width: 135,
        height: 200,
      ),
    );
  }
}
