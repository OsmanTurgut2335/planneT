
import 'package:allplant/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 30, fontFamily: 'Montserrat'),
        // Diğer text stilleri...
      ),
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        bodyMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        // Diğer text stilleri...
      ),
    );
  }
}
