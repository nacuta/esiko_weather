import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testingbloc/Data/current.dart';
import 'package:testingbloc/pages/search_page.dart';
import 'package:testingbloc/Widgets/icon_delegate.dart';
import 'package:testingbloc/bloc/data_bloc/data_from_json_bloc.dart';
import 'package:testingbloc/constants.dart';

import '../Widgets/forcast_widget.dart';
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

    var degree = '\u00B0';
    bool isCelsius = unit == 1 ? true : false;
    Color isSelectedColor = unit == 2 ? KNewPrimaryColor : Colors.grey;
    Color isCelsiusSelected = unit == 1 ? KNewPrimaryColor : Colors.grey;

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
              style: kStyleGoogleLato.copyWith(
                fontSize: 17,
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
                      cityBlocRead.add(GetListFromJsonEvent(city));
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
                  style: kStyleGoogleLato.copyWith(
                      fontSize: 20, letterSpacing: 1.60),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  isCelsius
                      ? '${apiResponse.current!.tempC.toInt()}$degree'
                      : '${apiResponse.current!.tempF.toInt()}$degree',
                  textAlign: TextAlign.center,
                  style: kStyleGoogleLato.copyWith(fontSize: 78),
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
                        style: kStyleGoogleLato.copyWith(fontSize: 18),
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
                        style: kStyleGoogleLato.copyWith(fontSize: 18),
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
                      style: kStyleGoogleLato,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ForcastWidget(
                          iconPath:
                              forecastList[0].day.condition.code.toString(),
                          forcastTepmerature: isCelsius
                              ? '${forecastList[0].day.maxtempC!.toInt()}'
                              : '${forecastList[0].day.maxtempF!.toInt()}',
                          forcastDayOfWeek: DateFormat('EEE')
                              .format(DateTime.parse(forecastList[0].date))),
                      ForcastWidget(
                          iconPath:
                              forecastList[1].day.condition.code.toString(),
                          forcastTepmerature: isCelsius
                              ? '${forecastList[1].day.maxtempC!.toInt()}'
                              : '${forecastList[1].day.maxtempF!.toInt()}',
                          forcastDayOfWeek: DateFormat('EEE')
                              .format(DateTime.parse(forecastList[1].date))),
                      ForcastWidget(
                          iconPath:
                              forecastList[2].day.condition.code.toString(),
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
}
