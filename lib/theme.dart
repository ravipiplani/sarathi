import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YathaarthTheme {
  YathaarthTheme._();

  static const kPadding8 = 8.0;
  static const kPadding16 = 16.0;
  static const kPadding32 = 32.0;

  Color primaryColor = Color(0xff004c8c);
  Color accentColor = Color(0xffffca29);

  static ThemeData blue = ThemeData(
      primaryColor: Colors.lightBlue[800],
      accentColor: Colors.amber[400],
      accentColorBrightness: Brightness.light,
      inputDecorationTheme: InputDecorationTheme(filled: true),
      appBarTheme: AppBarTheme(
        elevation: 0
      ),
      textTheme: GoogleFonts.montserratTextTheme());
}
