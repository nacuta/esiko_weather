import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Widgets/glassmorphism.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/Views/table_glassmorphism_view.dart';
import 'package:testingbloc/Views/temp_and_icon.dart';
import 'Data/current.dart';
import 'Data/api_data.dart';
import 'Views/small_display_forcast.dart';
import 'package:testingbloc/utils.dart';

class HomePageInitial extends StatefulWidget {
  const HomePageInitial({super.key});

  @override
  State<HomePageInitial> createState() => _HomePageInitialState();
}

class _HomePageInitialState extends State<HomePageInitial> {
  final DataFromJsonBloc _meteoBloc = DataFromJsonBloc();

  @override
  void initState() {
    _meteoBloc.add((GetListFromJson()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _meteoBloc,
      child: BlocListener<DataFromJsonBloc, DataFromJsonState>(
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
            return const CircularProgressIndicator();
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
      ),
    );
  }

  Widget _firstPageView(BuildContext context, CurrentWeather? apiResponse) {
    if (apiResponse != null) {
      var currentTemp = apiResponse.current!.tempC.toInt();
      var date = normalizeStringToParse(apiResponse.location!.localtime);
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
                                apiResponse.location!.name,
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
                          codeTextSituation: apiResponse
                              .forecast!.forecastday[0].day.condition.text),
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
