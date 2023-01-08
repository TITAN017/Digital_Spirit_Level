import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Color(0xfff1fdff),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xff3ac7c4)),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xff1a1a1a),
    buttonTheme: ButtonThemeData(buttonColor: Color(0xff808080)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white24,
      elevation: 0,
    ),
  );
  static Map<int, ThemeData> themes = {
    1: CustomTheme.darkTheme,
    0: CustomTheme.lightTheme,
  };
}
