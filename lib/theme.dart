import 'package:flutter/material.dart';

class AppThemes {
  static List<ThemeData> themes = [
    defaultTheme,
    pink,
    green,
    purple,
    teal,
    brown,
    yellow,
  ];

  // default
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 0, 122, 188),
  );

  // pink
  static ThemeData pink = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromRGBO(188, 0, 74, 1.0),
  );

  // green
  static ThemeData green = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromRGBO(76, 217, 100, 1.0),
  );

  // purple
  static ThemeData purple = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromRGBO(88, 86, 214, 1.0),
  );

  // teal
  static ThemeData teal = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.teal,
  );
  // brown
  static ThemeData brown = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 163, 68, 0),
  );

  // yellow
  static ThemeData yellow = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 255, 204, 0),
  );
}
