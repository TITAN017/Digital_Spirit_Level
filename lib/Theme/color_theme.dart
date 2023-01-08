import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black26),
      backgroundColor: const Color(0xfff1fdff),
      buttonTheme: const ButtonThemeData(buttonColor: Color(0xff3ac7c4)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff3ac7c4),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white60,
        elevation: 0,
      ));
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: const Color(0xff1a1a1a),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xff808080)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xff3ac7c4),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white24,
      elevation: 0,
    ),
  );
  static Map<int, ThemeData> themes = {
    1: CustomTheme.darkTheme,
    0: CustomTheme.lightTheme,
  };
  static Map<int, Color> textColor = {0: Colors.black87, 1: Colors.white};
}
