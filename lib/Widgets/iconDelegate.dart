import 'package:flutter/material.dart';
import 'package:testingbloc/Widgets/clouds.dart';
import 'package:testingbloc/Widgets/clouds_and_sun.dart';
import 'package:testingbloc/Widgets/sun.dart';

class IconDelegate extends StatelessWidget {
  const IconDelegate({super.key, required this.codetext});
  final String codetext;
  @override
  Widget build(BuildContext context) {
    return _getIconWidget(codetext: codetext);
  }
}

Widget _getIconWidget({String? codetext}) {
  switch (codetext) {
    // "text": "Sunny",
    //               "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
    //               "code": 1000
    case "Sunny":
      return const Align(alignment: Alignment.bottomRight, child: Sun());
    case "Partly cloudy":
      return const CloudAndSun();
    //  "text": "Partly cloudy",
    //   "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png",
    //   "code": 1003
    case "Patchy rain possible":
      // "text": "Patchy rain possible",
      // "icon": "//cdn.weatherapi.com/weather/64x64/night/176.png",
      // "code": 1063
      return const Clouds();
    case "Clear":
      // "text": "Clear",
      //  "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png",
      //  "code": 1000
      return const Sun();
    default:
      return Container();
  }
}
