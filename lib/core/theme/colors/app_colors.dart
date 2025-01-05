import 'package:dailyquotes/core/theme/colors/contrast_color_helper.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  // static Color background = const Color(0xff303b4d);
//  static Color primary = const Color(0xfff48bc4);
  // static Color secondaryPrimary = const Color(0xffa23bae);

//getters
  static Color get background => const Color(0xff303b4d);
  static Color get secondaryPrimary => const Color(0xfff48bc4);
  static Color get primary => const Color(0xffa23bae);
  static Color get text => Colors.white;
  static Color get iconCard =>
      ContrastColorHelper.CardContrastColor(primary, secondaryPrimary);
  static Color get icon => ContrastColorHelper.contrastColor(secondaryPrimary);
  static Color get floatingIcon => ContrastColorHelper.contrastColor(primary);
  static Color get textBG => ContrastColorHelper.contrastBGColor(background);
  static Color get defaultAddbtnColor =>
      const Color.fromARGB(255, 96, 143, 243);
  static Color get unselectedItemColor => const Color(0xff687389);
  static Color get selectedItemColor => const Color(0xfff48bc4);
  static List<Color> gradientColors = const [
    Color(0xfffcaac4),
    Color(0xfff48bc4),
    Color(0xffa23bae),
  ];

//setters
  static set background(Color color) => background = color;
  static set primary(Color color) => primary = color;
  static set secondaryPrimary(Color color) => secondaryPrimary = color;
}
