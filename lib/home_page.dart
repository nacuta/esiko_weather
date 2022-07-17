import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Views/search_page.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Views/table_glassmorphism_view.dart';
import 'package:testingbloc/Views/temp_and_icon.dart';
import 'Data/current.dart';
import 'Data/api_data.dart';
import 'Views/small_display_forcast.dart';
import 'package:testingbloc/utils.dart';

import 'chart.dart';

class HomePageInitial extends StatefulWidget {
  const HomePageInitial({super.key});

  @override
  State<HomePageInitial> createState() => _HomePageInitialState();
}

class _HomePageInitialState extends State<HomePageInitial> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DataFromJsonBloc, DataFromJsonState>(
      listener: (context, state) {
        if (state is DataFromJsonEror) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
      },
      child: BlocBuilder<DataFromJsonBloc, DataFromJsonState>(
          builder: (context, state) {
        if (state is DataFromJsonInitial) {
          return Center(child: Text(state.toString()));
        }
        if (state is DataFromJsonLoading) {
          return const CircularProgressIndicator();
        }
        if (state is DataFromJsonLoaded) {
          return _firstPageView(context, state.apiResponse);
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _firstPageView(BuildContext context, CurrentWeather? apiResponse) {
    if (apiResponse != null) {
      List<Forecastday>? forecast = apiResponse.forecast?.forecastday;
      var currentTemp = apiResponse.current!.tempC.toInt();
      var date = normalizeStringToParse(apiResponse.location!.localtime);
      final moonLanding = DateTime.parse(date);
      var dateNow = date.substring(0, 10);

      //search bar
      Icon customIcon = const Icon(Icons.search);
      Widget customSearchBar = const Text('My Personal Journal');

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
                Column(
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
                              apiResponse.location!.name,
                              style: googleFontStyle.copyWith(fontSize: 25),
                            ),
                          ],
                        ),
                        // Todo : Implement a search bar for location to be added
                        IconButton(
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          onPressed: () async {
                            // // method to show the search bar
                            // showSearch(
                            //   context: context,
                            //   // delegate to customize the search bar
                            //   delegate: CustomSearchDelegate(),
                            // );

                            final city = await Navigator.of(context)
                                .push(SearchPage.route());
                            await context
                                .read<DataFromJsonBloc>()
                                .getApiResponse(city);
                          },
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
                      codeTextSituation: apiResponse
                          .forecast!.forecastday[0].day.condition.text,
                    ),
                    // Implement Chart for hourly temperature
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: 200,
                        width: MediaQuery.of(context).size.width * 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ChartPageView(
                            forecastData: forecast!,
                          ),
                        ),
                      ),
                    ),
                    // Text(
                    //   '01,02,03,04,05',
                    //   style: TextStyle(letterSpacing: 20),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 5,
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
                                  index: index,
                                  futureApiData: apiResponse,
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
      return const Center(child: Text('Not a valid data'));
    }
  }
}
