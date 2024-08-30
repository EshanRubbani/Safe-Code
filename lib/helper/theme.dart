import 'package:flutter/material.dart';

const Color primaryPurple = Color(0xFF6200EE);
const Color secondaryPurple = Color(0xFF3700B3);
const Color white = Colors.white;
const Color black = Colors.black;

final ThemeData myTheme = ThemeData(
  primaryColor: primaryPurple,
  hintColor: secondaryPurple,
  backgroundColor: white,
  scaffoldBackgroundColor: white,
  appBarTheme: const AppBarTheme(
    color: white,
    iconTheme: IconThemeData(color: black),
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      color: black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    bodyText1: TextStyle(
      color: black,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
  ),
);
