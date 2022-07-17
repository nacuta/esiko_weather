import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:testingbloc/utils.dart';

TextStyle googleFontStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.bold,
    foreground: Paint()..shader = linearGradient,
    fontSize: 10);

Color kPrimaryColor = const Color(0xFF5156ED);
