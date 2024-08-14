import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFD61355);
  static const Color secondary = Color.fromARGB(255, 245, 132, 132);
  static const Color red = Color(0xFFFF0000);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color yellow = Colors.yellow;
  static Color grey = Colors.black.withOpacity(0.5);
  static const Color charcoalGray = Color(0xFF3B3B3B);
  static const LinearGradient gradientPrimary = LinearGradient(colors: [
    Color(0xFFD61355),
    Color(0xFFFF0000),
  ]);
  static const LinearGradient gradientSecondary = LinearGradient(colors: [
    Color(0xFFFFF0F0),
    Color(0xFFFFDFDF),
  ]);
  static const LinearGradient gradientCard = LinearGradient(colors: [
    Color(0xFFFF0000),
    Color(0xFFFFB4B4),
  ]);
  static const Color inactiveDotColor = Color(0xFFE6E6E6);
  static Color shadowBlue = const Color(0xFF5A6CEA).withOpacity(0.1);
}
