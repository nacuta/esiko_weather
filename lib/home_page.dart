import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Views/search_page.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:testingbloc/Widgets/hydro.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Views/table_glassmorphism_view.dart';
import 'package:testingbloc/Views/temp_and_icon.dart';
import 'package:testingbloc/search.dart';
import 'Data/current.dart';
import 'Data/api_data.dart';
import 'Views/small_display_forcast.dart';
import 'package:testingbloc/utils.dart';

import 'Widgets/chart.dart';

class HomePageInitial extends StatefulWidget {
  const HomePageInitial({super.key});

  @override
  State<HomePageInitial> createState() => _HomePageInitialState();
}

class _HomePageInitialState extends State<HomePageInitial> {
  final blocSearch = DataFromJsonBloc();

  @override
  Widget build(BuildContext context) {
    context.read<DataFromJsonBloc>().add(GetListFromJson('Arad'));
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
          return Scaffold(body: Center(child: Text(state.toString())));
        }
        if (state is DataFromJsonLoading) {
          return const Center(child: CircularProgressIndicator());
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

      return BlocProvider(
        create: (context) => DataFromJsonBloc(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: true,
          //  res/izeToAvoidBottomPadding: false,
          extendBodyBehindAppBar: true,
          appBar: /*  SearchAppBarWidget(), */
              AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: kPrimaryColor,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                  centerTitle: true,
                  title: Text(
                    apiResponse.location!.name,
                    style: TextStyle(
                        color: Colors.deepPurple.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                IconButton(
                    onPressed: () async {
                      var city = await showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                            BlocProvider.of<DataFromJsonBloc>(context),
                          ));
                      print('City $city');
                      // context.watch<DataFromJsonBloc>().state;
                      // if (city.isNotEmpty) {
                      //   context
                      //       .read<DataFromJsonBloc>()
                      //       .add(GetListFromJson(city));
                      // }
                    },
                    icon: Icon(
                      Icons.search,
                      color: kPrimaryColor,
                    )),
                // SearchBar(),
              ]),
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/background.jpg"),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Row(
                            //       children: [
                            //         Icon(
                            //           Icons.location_on_outlined,
                            //           size: 25,
                            //           color: Colors.deepPurple.shade700,
                            //         ),
                            //         Text(
                            //           apiResponse.location!.name,
                            //           style: TextStyle(
                            //               color: Colors.deepPurple.shade700,
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ],
                            //     ),
                            //     // Todo : Implement a search bar for location to be added
                            //     // IconButton(
                            //     //   icon: const Icon(
                            //     //     Icons.search,
                            //     //     size: 30,
                            //     //   ),
                            //     //   onPressed: () async {
                            //     //     // // method to show the search bar
                            //     //     // showSearch(
                            //     //     //   context: context,
                            //     //     //   // delegate to customize the search bar
                            //     //     //   delegate: CustomSearchDelegate(),
                            //     //     // );

                            //     //     final city = await Navigator.of(context)
                            //     //         .push(SearchPage.route());
                            //     //     await context
                            //     //         .read<DataFromJsonBloc>()
                            //     //         .getApiResponse(city);
                            //     //   },
                            //     // ),
                            //   ],
                            // ),

                            Container(
                              margin: const EdgeInsets.only(top: 75),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dateNow,
                                    style:
                                        googleFontStyle.copyWith(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            TempAndIcon(
                              currentTem: currentTemp,
                              codeTextSituation: apiResponse
                                  .forecast!.forecastday[0].day.condition.text,
                            ),
                            const Hydro(),
                            // Implement Chart for hourly temperature
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 190,
                                width: MediaQuery.of(context).size.width * 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ChartPageView(
                                    forecastData: forecast!,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: 3,
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
                              },
                            )

                            // TblForcastGlassmorphView(
                            //     futureApiData: futureApiData,
                            //     moonLanding: moonLanding),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('Not a valid data'));
    }
  }
}

class City {
  final String name;

  const City(this.name);

  @override
  String toString() => 'City { name: $name }';
}
