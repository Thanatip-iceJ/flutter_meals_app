import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primayColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 51, 153, 255),
    brightness: Brightness.dark);
final initialTheme = ThemeData(
  colorScheme: primayColorScheme,
  appBarTheme: AppBarTheme(
      backgroundColor: primayColorScheme.onInverseSurface,
      foregroundColor: primayColorScheme.primary),
  textTheme: GoogleFonts.rubikTextTheme(),
);
