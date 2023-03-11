import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  useMaterial3: true,
  //light scheme
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 51, 0, 68),
    onPrimary: Color.fromARGB(255, 221, 199, 248),
    secondary: Color.fromARGB(255, 221, 199, 248),
    onSecondary: Color.fromARGB(255, 51, 0, 68),
    error: Color.fromARGB(255, 186, 26, 26),
    onError: Color.fromARGB(255, 255, 218, 214),
    background: Color.fromARGB(255, 255, 255, 255),
    onBackground: Color.fromARGB(255, 51, 0, 68),
    surface: Color.fromARGB(255, 51, 0, 68),
    onSurface: Color.fromARGB(255, 221, 199, 248),
  ),
);
