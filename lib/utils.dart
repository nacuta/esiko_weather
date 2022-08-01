import 'package:flutter/material.dart';

import 'bloc/cubit/weather_cubit.dart';

String normalizeStringToParse(String date) {
  var aa = date.split(' ');
  if (aa[1].length <= 4) {
    aa[1] = '0${aa[1]}';
    date = '${aa[0]} ${aa[1]}';
  }
  return date;
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xFF5156ED),
    const Color(0xFF76B2EF),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 470.0, 200.0));
