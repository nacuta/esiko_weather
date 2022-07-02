import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Views/table_glassmorphism_view.dart';
import 'package:testingbloc/Views/temp_and_icon.dart';
import 'Data/current.dart';
import 'Data/data.dart';
import 'Views/small_display_forcast.dart';

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
                  // width: double.infinity,
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
                      GlassMorphism(
                        start: 0.6,
                        end: 0.9,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        child: Column(
                          children: [
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
                                      style: googleFontStyle.copyWith(
                                          fontSize: 25),
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
                                codeTextSituation: futureApiData.forecast
                                    .forecastday[0].day.condition.text),
                            Container(
                              height: 200,
                              //Todo: implement charts here
                              child: Text("Charts"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                          height: 150,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var addingDate =
                                    moonLanding.add(Duration(days: index));

                                var dayOfTheWeek =
                                    DateFormat('EEE').format(addingDate);
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      SmallDisplayForcast(
                                        forcastDay: dayOfTheWeek,
                                        imagePath:
                                            'https:${futureApiData.forecast.forecastday[index].day.condition.icon}',
                                        forcastMaxTemp:
                                            '${futureApiData.forecast.forecastday[index].day.maxtempC?.floor()}\u00b0',
                                        forcastMinTemp:
                                            '${futureApiData.forecast.forecastday[index].day.mintempC.floor()}\u00b0',
                                      ),
                                      // const SizedBox(
                                      //   width: 10,
                                      // )
                                    ],
                                  ),
                                );
                              })

                          // TblForcastGlassmorphView(
                          //     futureApiData: futureApiData,
                          //     moonLanding: moonLanding),
                          ),
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
    if (aa[1].length <= 4) {
      aa[1] = '0${aa[1]}';
      date = '${aa[0]} ${aa[1]}';
    }
    return date;
  }
}
