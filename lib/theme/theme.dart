import 'package:flutter/material.dart';

ThemeData lightMode=ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.green[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.amber[100],
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Algerian',
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.red[100]!,
          offset: const Offset(0, 0),
          blurRadius: 10,
        ),
      ],
    ),
  ),
);

ThemeData darkMode=ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.yellow[900],
    titleTextStyle: TextStyle(
      fontSize: 20.0,
      fontFamily: 'Algerian',
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.red[100]!,
          offset: const Offset(0, 0),
          blurRadius: 10,
        ),
      ],
    ),
  ),
);