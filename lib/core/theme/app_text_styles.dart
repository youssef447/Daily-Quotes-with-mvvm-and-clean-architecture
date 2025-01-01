import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'text/app_font_weights.dart';

abstract class AppTextStyles {
  // --------------------- REGULAR Text Styles - w400 ---------------------
  static TextStyle get font18MediumAmita => GoogleFonts.amita(
        color: AppColors.text,
        fontSize: 18.sp,
        fontWeight: AppFontWeights.extraBold,
      );
  static TextStyle get font14RegularABeeZee => GoogleFonts.aBeeZee(
        color: AppColors.text,
        fontSize: 14.sp,
        fontWeight: AppFontWeights.regular,
      );
  static TextStyle get font14MediumABeeZee => GoogleFonts.aBeeZee(
        color: AppColors.text,
        fontSize: 14.sp,
        fontWeight: AppFontWeights.medium,
      );
}
