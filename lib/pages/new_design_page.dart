import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:testingbloc/Views/search_page.dart';
import 'package:testingbloc/Widgets/icon_delegate.dart';
import 'package:testingbloc/bloc/data_bloc/data_from_json_bloc.dart';
import 'package:testingbloc/constants.dart';

import '../bloc/cubit/weather_cubit.dart';
import '../utils.dart';

enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}

class NewDesignPage extends StatelessWidget {
  const NewDesignPage(
      {super.key, required this.context, required this.apiResponse});
  final BuildContext context;
  final CurrentWeather apiResponse;

  @override
  Widget build(BuildContext context) {
    List<Forecastday>? forecastList = apiResponse.forecast!.forecastday;

    var unit = context.watch<WeatherCubit>().state.temperatureUnits;
    final cityBlocRead = context.read<DataFromJsonBloc>();
    print(unit.runtimeType);
    print(unit);
    var degree = '\u00B0';
    bool isCelsius = unit == 1 ? true : false;
    Color isSelectedColor = unit == 2 ? const Color(0xff002b30) : Colors.grey;
    Color isCelsiusSelected = unit == 1 ? const Color(0xff002b30) : Colors.grey;

    return SafeArea(
        top: true,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: const Icon(
              Icons.place,
              color: Color(0xff002b30),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              apiResponse.location!.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color(0xff002b30),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.36,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    var city = await showSearch(
                        context: context,
                        delegate: CustomSearchDelegate('Enter a city'));
                    print('City $city');
                    if (city.isNotEmpty) {
                      cityBlocRead.add(GetListFromJson(city));
                    }
                  },
                  color: Colors.black,
                  icon: const Icon(
                    Icons.search,
                  ))
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  // Color(0xff0093E9),
                  Color(0xff80D0C7),
                  Color(0xff5BC0EB),
                  // linear-gradient(160deg, #0093E9 0%, #80D0C7 100%);
                ])),
            child: Column(
              children: [
                // Container(
                //   margin: const EdgeInsets.only(top: 26),
                //   width: 266,
                //   height: 204,
                //   child: Image.asset(
                //     'assets/sunInClouds.png',
                //   ),
                // ),
                IconDelegate(
                  codetext: apiResponse.current!.condition.code.toString(),
                  isDay: apiResponse.current!.isDay,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  apiResponse.current!.condition.text.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: const Color(0xff002b30),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.60,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  isCelsius
                      ? '${apiResponse.current!.tempC.toInt()}$degree'
                      : '${apiResponse.current!.tempF.toInt()}$degree',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: const Color(0xff002b30),
                    fontSize: 78,
                    // fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<WeatherCubit>().toCelsius();
                      },
                      child: Text(
                        "C°",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isCelsiusSelected,
                          fontSize: 24,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Text('|',
                        style: TextStyle(
                            fontSize: 24,
                            // fontWeight: FontWeight.,
                            letterSpacing: 0,
                            height: 0)),
                    TextButton(
                      onPressed: () {
                        context.read<WeatherCubit>().toFahrenheit();
                      },
                      child: Text(
                        "F°",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelectedColor,
                          fontSize: 24,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shower_outlined,
                      color: Color(0xff23395B),
                      size: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${apiResponse.current!.humidity}%',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: const Color(0xff23395B),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.air_outlined,
                      color: Color(0xff23395B),
                      size: 28,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${apiResponse.current!.windKph} Km/h',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: const Color(0xff23395B),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 8, 8),
                    child: Text(
                      DateFormat('EEEEE, d, MMM').format(
                        DateTime.parse(
                          normalizeStringToParse(
                              apiResponse.location!.localtime),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: const Color(0xff002b30),
                        fontSize: 25,
                        // fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      contauhcuhcue(
                          iconData: Icons.wb_sunny_outlined,
                          forcastTepmerature: isCelsius
                              ? '${forecastList[0].day.maxtempC!.toInt()}'
                              : '${forecastList[0].day.maxtempF!.toInt()}',
                          forcastDayOfWeek: DateFormat('EEE')
                              .format(DateTime.parse(forecastList[0].date))),
                      contauhcuhcue(
                          iconData: Icons.wb_cloudy_outlined,
                          forcastTepmerature: isCelsius
                              ? '${forecastList[1].day.maxtempC!.toInt()}'
                              : '${forecastList[1].day.maxtempF!.toInt()}',
                          forcastDayOfWeek: DateFormat('EEE')
                              .format(DateTime.parse(forecastList[1].date))),
                      contauhcuhcue(
                          iconData: Icons.thunderstorm_outlined,
                          forcastTepmerature: isCelsius
                              ? '${forecastList[2].day.maxtempC!.toInt()}'
                              : '${forecastList[2].day.maxtempF!.toInt()}',
                          forcastDayOfWeek: DateFormat('EEE')
                              .format(DateTime.parse(forecastList[2].date))),
                    ]),
              ],
            ),
          ),
        ));
  }

  Widget contauhcuhcue({
    required IconData iconData,
    required String forcastTepmerature,
    required String forcastDayOfWeek,
  }) {
    return Container(
      width: 102,
      height: 142,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff94f4f4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              forcastDayOfWeek,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: const Color(0xff002b30),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(
            iconData,
            color: Colors.white,
            size: 40,
          ),
          Text(
            forcastTepmerature,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: const Color(0xff002b30),
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
