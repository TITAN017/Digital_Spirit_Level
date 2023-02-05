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

  //Neo Button Theme
  static Map<int, List> neoTheme = {
    0: const [Colors.white, Colors.white, Color(0xFFA7A9AF)],
    1: const [Color(0xff2e3239), Color(0xff35393f), Color(0xff23262a)]
  };
  static Map<int, ThemeData> themes = {
    1: CustomTheme.darkTheme,
    0: CustomTheme.lightTheme,
  };
  static Map<int, Color> textColor = {0: Colors.black87, 1: Colors.white};
  static Map<int, Shader> creditTheme = {
    1: const LinearGradient(
      colors: <Color>[Color(0xFFf43b47), Color(0xFF453a94)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    0: const LinearGradient(
      colors: <Color>[Color(0xFF536976), Color(0xFF292E49)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))
  };
}
