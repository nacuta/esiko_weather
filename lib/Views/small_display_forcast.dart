import 'package:flutter/material.dart';
import 'package:testingbloc/Data/current.dart';

import '../constants.dart';

class SmallDisplayForcast extends StatelessWidget {
  const SmallDisplayForcast({
    super.key,
    required this.index,
    required this.futureApiData,
    required this.forcastDay,
  });
  final String forcastDay;
  final int index;
  final CurrentWeather futureApiData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: kPrimaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: SizedBox(
        width: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 0.8),
              child: Text(
                forcastDay.substring(0, forcastDay.length).toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.9,
                ),
                textScaleFactor: 0.9,
              ),
            ),
            Image(
              image: NetworkImage(
                'https:${futureApiData.forecast?.forecastday[index].day.condition.icon}',
              ),
              height: 40,
            ),
            Text(
              '${futureApiData.forecast?.forecastday[index].day.maxtempC?.floor()}\u00b0',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '${futureApiData.forecast?.forecastday[index].day.mintempC.floor()}\u00b0',
              style: TextStyle(
                color: Color(0xFF8786FC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
