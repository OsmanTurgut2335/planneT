import 'package:allplant/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      textTheme: TextTheme(
        bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
        bodyMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: Colors.black, fontFamily: 'ProtestRevolution'),
        headlineSmall: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Montserrat'),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(fontSize: 30, fontFamily: 'Montserrat'),
        // Diğer text stilleri...
      ),

      splashColor: Colors.transparent, // Removes ripple effect

      appBarTheme: AppBarTheme(color: Colors.transparent, centerTitle: true),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF569033),
        extendedTextStyle: TextStyle(color: Colors.black, fontFamily: 'ProtestRevolution'),
      ),
      scaffoldBackgroundColor: AppColors.alternateScaffoldBackground,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF569033))),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF2B3D36))),
        // Label style (the text for the label)
        labelStyle: TextStyle(color: Colors.black, fontFamily: 'ProtestRevolution'),
      ),
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
