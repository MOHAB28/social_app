import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defualtColor = Colors.blue;

ThemeData lightMode = ThemeData(
  primarySwatch: defualtColor,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Jannah',
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontFamily: 'Jannah',
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color.fromRGBO(45, 136, 255, 1),
    unselectedItemColor: Colors.black,
  ),
);
