import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Colors.deepPurple.shade700,
    Color.fromARGB(255, 118, 178, 239),
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 470.0, 200.0));

TextStyle googleFontStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.bold,
    foreground: Paint()..shader = linearGradient,
    fontSize: 10);
