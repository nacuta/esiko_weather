import 'package:flutter/material.dart';

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
    Colors.deepPurple.shade700,
    const Color(0xFF76B2EF),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 470.0, 200.0));
