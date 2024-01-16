import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'appColors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.defaultColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.defaultColor,
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle:  TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSpacing: 20.0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.defaultColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.defaultColor,
    ),
    backgroundColor: AppColors.defaultColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
    refreshBackgroundColor: AppColors.defaultColor,
    linearMinHeight: 5,
  ),

  
  dividerTheme: const DividerThemeData(thickness: 1.5, color: Colors.white),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 15.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);
