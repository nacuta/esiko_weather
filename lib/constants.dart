import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:testingbloc/utils.dart';

TextStyle googleFontStyle = GoogleFonts.oswald(
    fontWeight: FontWeight.bold,
    foreground: Paint()..shader = linearGradient,
    fontSize: 10);

TextStyle kStyleGoogleLato = GoogleFonts.lato(
  color: KNewPrimaryColor,
  fontSize: 25,
  fontWeight: FontWeight.w500,
);

Color kPrimaryColor = const Color(0xFF5156ED);

Color KNewPrimaryColor = const Color(0xff002b30);
