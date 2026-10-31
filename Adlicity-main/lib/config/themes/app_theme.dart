import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    // brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppStrings.fontFamily,
    appBarTheme:  AppBarTheme(
        centerTitle: true,
        color: Colors.white,
        // backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        // foregroundColor: Colors.white,
        
        elevation: 0,
        shadowColor: AppColors.third,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w600, color: AppColors.primary, fontSize: 20)),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
     inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red), // Change border color here
          borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
        ),
      ),

    useMaterial3: true,
    
  );
}
