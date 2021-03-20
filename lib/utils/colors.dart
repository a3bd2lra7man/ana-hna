import 'package:flutter/material.dart';

class AppColors{
  static MaterialColor primary = colors['black'];
  static MaterialColor second = colors['white'];
  static MaterialColor third = Colors.grey;

  static var colors = {
  'black':  MaterialColor(
    0xFF000000,
    <int, Color>{
        50: Color(0xFF676767),
        100: Color(0xFF5a5a5a),
        700: Color(0xFF4d4d4d),
        300: Color(0xFF404040),
        400: Color(0xFF2f2f2f),
        500: Color(0xFF202020),
        600: Color(0xFF191919),
        200: Color(0xFF0f0f0f),
        800: Color(0xFF0a0a0a),
        900: Color(0xFF000000),
    },
  ),
  'white':MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300:Color(0xFFF5F5F5),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFd9d9d9),
      600: Color(0xFFc9c9c9),
      700: Color(0xFFc3c3c3),
      800: Color(0xFFafafaf),
      900: Color(0xFF9c9c9c),
    },
  ),
};
}