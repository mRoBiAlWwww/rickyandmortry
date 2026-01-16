import 'package:flutter/material.dart';
import 'package:robi/core/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.splashBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.splashBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
