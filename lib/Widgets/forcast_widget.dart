import 'package:flutter/material.dart';

import '../constants.dart';
import 'icon_delegate.dart';

class ForcastWidget extends StatelessWidget {
  const ForcastWidget(
      {Key? key,
      required this.iconPath,
      required this.forcastTepmerature,
      required this.forcastDayOfWeek})
      : super(key: key);

  final String iconPath;
  final String forcastTepmerature;
  final String forcastDayOfWeek;

  @override
  Widget build(BuildContext context) {
    var forecastIconsPath =
        IconDelegate.getIconPath(codetext: iconPath, isDay: 1);
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
              style: kStyleGoogleLato.copyWith(
                fontSize: 15,
              ),
            ),
          ),
          Image.asset(
            forecastIconsPath,
            width: 70,
            height: 70,
          ),
          Text(
            forcastTepmerature,
            textAlign: TextAlign.center,
            style: kStyleGoogleLato.copyWith(
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
