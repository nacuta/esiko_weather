import 'package:flutter/material.dart';
import 'package:testingbloc/Widgets/clouds.dart';
import 'package:testingbloc/Widgets/clouds_and_sun.dart';
import 'package:testingbloc/Widgets/sun.dart';

class IconDelegate extends StatelessWidget {
  const IconDelegate({super.key, required this.codetext, required this.isDay});
  final String codetext;
  final int isDay;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 26),
      width: 266,
      height: 204,
      child: Image.asset(
        getIconPath(codetext: codetext, isDay: isDay),
      ),
    );
  }

  static String getIconPath({required String? codetext, required int isDay}) {
    switch (codetext) {
      case "1000":
        // "day" : "Sunny",
        var dayIcon = 'assets/sunny1000day.png';
        // "night" : "Clear",
        var nightIcon = 'assets/clear1000night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      case "1003":
// 		"day" : "Partly cloudy",
        var dayIcon = 'assets/partlyCloudy1003day.png';
// 		"night" : "Partly cloudy",
        var nightIcon = 'assets/partlyCloudy1003night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      case "1006":
      case "1009":
      case "1030":
        // "day" : "Cloudy",
        var dayIcon = 'assets/cloudy1006day.png';
        // 		"night" : "Cloudy",
        var nightIcon = 'assets/cloudy1006night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      case "1063":
        // "day" : "Patchy rain possible",
        var dayIcon = 'assets/patchyRain1063day.png';
        // 	"night" : "Patchy rain possible",
        var nightIcon = 'assets/patchyRain1063night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      case "1066":
        // "day" : "Patchy snow possible",
        var dayIcon = 'assets/patchySnow1066day.png';
        // 	"night" : "Patchy rain possible",
        var nightIcon = 'assets/patchySnow1066night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      case "1069":
      case "1072":
        // "day" : "Patchy sleet possible",
        var dayIcon = 'assets/patchySleet1069day.png';
        // 	"night" : "Patchy sleet possible",
        var nightIcon = 'assets/patchySleet1069night.png';
        var response = isDay == 1 ? dayIcon : nightIcon;
        return response;

      // case "1087":
      //   // "day" : "Thundery outbreaks possible",
      //   var dayIcon = 'assets/patchySleet1069day.png';
      //   // 	"night" :"Thundery outbreaks possible",
      //   var nightIcon = 'assets/patchySleet1069night.png';
      //   var response = isDay == 1 ? dayIcon : nightIcon;
      //   return response;

      default:
        return 'assets/cloudy1006day.png';
    }
  }
}



// [

// 	{
// 		"code" : 1087,
// 		"day" : "Thundery outbreaks possible",
// 		"night" : "Thundery outbreaks possible",
// 		"icon" : 200
// 	},
// 	{
// 		"code" : 1114,
// 		"day" : "Blowing snow",
// 		"night" : "Blowing snow",
// 		"icon" : 227
// 	},
// 	{
// 		"code" : 1117,
// 		"day" : "Blizzard",
// 		"night" : "Blizzard",
// 		"icon" : 230
// 	},
// 	{
// 		"code" : 1135,
// 		"day" : "Fog",
// 		"night" : "Fog",
// 		"icon" : 248
// 	},
// 	{
// 		"code" : 1147,
// 		"day" : "Freezing fog",
// 		"night" : "Freezing fog",
// 		"icon" : 260
// 	},
// 	{
// 		"code" : 1150,
// 		"day" : "Patchy light drizzle",
// 		"night" : "Patchy light drizzle",
// 		"icon" : 263
// 	},
// 	{
// 		"code" : 1153,
// 		"day" : "Light drizzle",
// 		"night" : "Light drizzle",
// 		"icon" : 266
// 	},
// 	{
// 		"code" : 1168,
// 		"day" : "Freezing drizzle",
// 		"night" : "Freezing drizzle",
// 		"icon" : 281
// 	},
// 	{
// 		"code" : 1171,
// 		"day" : "Heavy freezing drizzle",
// 		"night" : "Heavy freezing drizzle",
// 		"icon" : 284
// 	},
// 	{
// 		"code" : 1180,
// 		"day" : "Patchy light rain",
// 		"night" : "Patchy light rain",
// 		"icon" : 293
// 	},
// 	{
// 		"code" : 1183,
// 		"day" : "Light rain",
// 		"night" : "Light rain",
// 		"icon" : 296
// 	},
// 	{
// 		"code" : 1186,
// 		"day" : "Moderate rain at times",
// 		"night" : "Moderate rain at times",
// 		"icon" : 299
// 	},
// 	{
// 		"code" : 1189,
// 		"day" : "Moderate rain",
// 		"night" : "Moderate rain",
// 		"icon" : 302
// 	},
// 	{
// 		"code" : 1192,
// 		"day" : "Heavy rain at times",
// 		"night" : "Heavy rain at times",
// 		"icon" : 305
// 	},
// 	{
// 		"code" : 1195,
// 		"day" : "Heavy rain",
// 		"night" : "Heavy rain",
// 		"icon" : 308
// 	},
// 	{
// 		"code" : 1198,
// 		"day" : "Light freezing rain",
// 		"night" : "Light freezing rain",
// 		"icon" : 311
// 	},
// 	{
// 		"code" : 1201,
// 		"day" : "Moderate or heavy freezing rain",
// 		"night" : "Moderate or heavy freezing rain",
// 		"icon" : 314
// 	},
// 	{
// 		"code" : 1204,
// 		"day" : "Light sleet",
// 		"night" : "Light sleet",
// 		"icon" : 317
// 	},
// 	{
// 		"code" : 1207,
// 		"day" : "Moderate or heavy sleet",
// 		"night" : "Moderate or heavy sleet",
// 		"icon" : 320
// 	},
// 	{
// 		"code" : 1210,
// 		"day" : "Patchy light snow",
// 		"night" : "Patchy light snow",
// 		"icon" : 323
// 	},
// 	{
// 		"code" : 1213,
// 		"day" : "Light snow",
// 		"night" : "Light snow",
// 		"icon" : 326
// 	},
// 	{
// 		"code" : 1216,
// 		"day" : "Patchy moderate snow",
// 		"night" : "Patchy moderate snow",
// 		"icon" : 329
// 	},
// 	{
// 		"code" : 1219,
// 		"day" : "Moderate snow",
// 		"night" : "Moderate snow",
// 		"icon" : 332
// 	},
// 	{
// 		"code" : 1222,
// 		"day" : "Patchy heavy snow",
// 		"night" : "Patchy heavy snow",
// 		"icon" : 335
// 	},
// 	{
// 		"code" : 1225,
// 		"day" : "Heavy snow",
// 		"night" : "Heavy snow",
// 		"icon" : 338
// 	},
// 	{
// 		"code" : 1237,
// 		"day" : "Ice pellets",
// 		"night" : "Ice pellets",
// 		"icon" : 350
// 	},
// 	{
// 		"code" : 1240,
// 		"day" : "Light rain shower",
// 		"night" : "Light rain shower",
// 		"icon" : 353
// 	},
// 	{
// 		"code" : 1243,
// 		"day" : "Moderate or heavy rain shower",
// 		"night" : "Moderate or heavy rain shower",
// 		"icon" : 356
// 	},
// 	{
// 		"code" : 1246,
// 		"day" : "Torrential rain shower",
// 		"night" : "Torrential rain shower",
// 		"icon" : 359
// 	},
// 	{
// 		"code" : 1249,
// 		"day" : "Light sleet showers",
// 		"night" : "Light sleet showers",
// 		"icon" : 362
// 	},
// 	{
// 		"code" : 1252,
// 		"day" : "Moderate or heavy sleet showers",
// 		"night" : "Moderate or heavy sleet showers",
// 		"icon" : 365
// 	},
// 	{
// 		"code" : 1255,
// 		"day" : "Light snow showers",
// 		"night" : "Light snow showers",
// 		"icon" : 368
// 	},
// 	{
// 		"code" : 1258,
// 		"day" : "Moderate or heavy snow showers",
// 		"night" : "Moderate or heavy snow showers",
// 		"icon" : 371
// 	},
// 	{
// 		"code" : 1261,
// 		"day" : "Light showers of ice pellets",
// 		"night" : "Light showers of ice pellets",
// 		"icon" : 374
// 	},
// 	{
// 		"code" : 1264,
// 		"day" : "Moderate or heavy showers of ice pellets",
// 		"night" : "Moderate or heavy showers of ice pellets",
// 		"icon" : 377
// 	},
// 	{
// 		"code" : 1273,
// 		"day" : "Patchy light rain with thunder",
// 		"night" : "Patchy light rain with thunder",
// 		"icon" : 386
// 	},
// 	{
// 		"code" : 1276,
// 		"day" : "Moderate or heavy rain with thunder",
// 		"night" : "Moderate or heavy rain with thunder",
// 		"icon" : 389
// 	},
// 	{
// 		"code" : 1279,
// 		"day" : "Patchy light snow with thunder",
// 		"night" : "Patchy light snow with thunder",
// 		"icon" : 392
// 	},
// 	{
// 		"code" : 1282,
// 		"day" : "Moderate or heavy snow with thunder",
// 		"night" : "Moderate or heavy snow with thunder",
// 		"icon" : 395
// 	}
// ]