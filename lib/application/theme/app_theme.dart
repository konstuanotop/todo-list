import 'package:flutter/material.dart';
import 'package:todo/application/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.darkBlue,
      secondary: AppColors.darkGray,
      surface: AppColors.palePurple,
      onSecondary: AppColors.white,
      tertiary: AppColors.red,
      onTertiary: AppColors.white,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.black),
      labelMedium: TextStyle(fontSize: 16, color: AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.palePurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
      ),
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: AppColors.white,
    ),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.white),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      shadowColor: AppColors.black,
      elevation: 4,
      scrolledUnderElevation: 4,
      backgroundColor: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.white,
  );
}
