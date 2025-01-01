import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.background,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleSpacing: 20.0.sp,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: AppColors.background,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
    ),
    backgroundColor: AppColors.background,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white,
    refreshBackgroundColor: AppColors.background,
    linearMinHeight: 5,
  ),
  dividerTheme: const DividerThemeData(thickness: 1.5, color: Colors.white),
  textTheme: TextTheme(
    titleLarge: TextStyle(
      fontSize: 22.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 15.0.sp,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      fontSize: 13.0.sp,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);
