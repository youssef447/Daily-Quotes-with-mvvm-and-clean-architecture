import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors/app_colors.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.background,
  ),
  dividerTheme: const DividerThemeData(thickness: 1.5, color: Colors.white),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
    ),
    backgroundColor: AppColors.background,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
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
