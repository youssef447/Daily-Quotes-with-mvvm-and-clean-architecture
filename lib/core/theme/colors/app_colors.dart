import 'package:dailyquotes/core/theme/colors/contrast_color_helper.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static final AppColors instance = AppColors._();
  Color background = const Color(0xff303b4d);
  Color primary = const Color(0xfff48bc4);
  Color secondaryPrimary = const Color(0xffa23bae);
  Color get text => Colors.white;
  Color get iconCard =>
      ContrastColorHelper.CardContrastColor(primary, secondaryPrimary);
  Color get icon => ContrastColorHelper.contrastColor(secondaryPrimary);
  Color get floatingIcon => ContrastColorHelper.contrastColor(primary);
  Color get textBG => ContrastColorHelper.contrastBGColor(background);
  Color get defaultAddbtnColor => const Color.fromARGB(255, 96, 143, 243);
  Color get unselectedItemColor => const Color(0xff687389);
  Color get selectedItemColor => const Color(0xfff48bc4);
  List<Color> gradientColors = const [
    Color(0xfffcaac4),
    Color(0xfff48bc4),
    Color(0xffa23bae),
  ];
}
