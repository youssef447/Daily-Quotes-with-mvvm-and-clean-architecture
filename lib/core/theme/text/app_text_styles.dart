import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/app_colors.dart';
import 'app_font_weights.dart';

abstract class AppTextStyles {
  // --------------------- REGULAR Text Styles - w400 ---------------------
  static TextStyle get font18MediumAmita => GoogleFonts.amita(
        color: AppColors.instance.text,
        fontSize: 18.sp,
        fontWeight: AppFontWeights.extraBold,
      );
  static TextStyle get font22MediumABeeZee => GoogleFonts.aBeeZee(
        color: AppColors.instance.text,
        fontSize: 22.sp,
        fontWeight: AppFontWeights.extraBold,
      );
  static TextStyle get font20MediumABeeZeePrimary => GoogleFonts.aBeeZee(
        color: AppColors.instance.primary,
        fontSize: 20.sp,
        fontWeight: AppFontWeights.medium,
      );
  static TextStyle get font14RegularABeeZee => GoogleFonts.aBeeZee(
        color: AppColors.instance.text,
        fontSize: 14.sp,
        fontWeight: AppFontWeights.regular,
      );
  static TextStyle get font14MediumABeeZee => GoogleFonts.aBeeZee(
        color: AppColors.instance.text,
        fontSize: 14.sp,
        fontWeight: AppFontWeights.medium,
      );
  static TextStyle get font14MediumABeeZeePrimary => GoogleFonts.aBeeZee(
        color: AppColors.instance.primary,
        fontSize: 14.sp,
        fontWeight: AppFontWeights.medium,
      );
  static TextStyle get font16MediumAmitaPrimary => GoogleFonts.amita(
        color: AppColors.instance.primary,
        fontSize: 16.sp,
        fontWeight: AppFontWeights.medium,
      );
}
