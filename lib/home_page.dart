import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Views/table_glassmorphism_view.dart';
import 'package:testingbloc/Views/tempAndIcon.dart';
import 'Data/current.dart';
import 'Data/data.dart';

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
    return FutureBuilder(
        future: apiResponse,
        builder: (context, snapshot) {
          var futureApiData = snapshot.data;
          if (futureApiData != null) {
            var currentTemp = futureApiData.current.tempC.toInt();
            var date =
                _normalizeStringToParse(futureApiData.location.localtime);
            final moonLanding = DateTime.parse(date);
            var dateNow = date.substring(0, 10);
            return Scaffold(
              body: SafeArea(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/background.jpg"),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Todo : Implement a search bar for location to be added
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 25,
                                color: Colors.deepPurple.shade700,
                              ),
                              Text(
                                futureApiData.location.name,
                                style: googleFontStyle.copyWith(fontSize: 25),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateNow,
                            style: googleFontStyle.copyWith(fontSize: 15),
                          )
                        ],
                      ),
                      TempAndIcon(
                          currentTem: currentTemp,
                          codeTextSituation: futureApiData
                              .forecast.forecastday[0].day.condition.text),
                      TblForcastGlassmorphView(
                          futureApiData: futureApiData,
                          moonLanding: moonLanding),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  String _normalizeStringToParse(String date) {
    var aa = date.split(' ');
    print(aa[1].length);
    if (aa[1].length <= 4) {
      print(aa.length);
      aa[1] = '0${aa[1]}';
      date = '${aa[0]} ${aa[1]}';
    }
    return date;
  }
}
