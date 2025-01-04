import 'package:dailyquotes/core/theme/colors/contrast_color_helper.dart';
import 'package:flutter/material.dart';

abstract class AppColors {
  static Color _background = Color(0xff303b4d);
  static Color _primary = Color(0xfff48bc4);
  static Color _secondaryPrimary = Color(0xffa23bae);

  static Color get background => _background;
  static Color get secondaryPrimary => _secondaryPrimary;
  static Color get primary => _primary;
  static Color get text => Colors.white;
  static Color get icon =>
      ContrastColorHelper.contrastColor(_primary, _secondaryPrimary);
  static Color get textBG => ContrastColorHelper.contrastBGColor(_background);
  static Color get defaultAddbtnColor => Color.fromARGB(255, 96, 143, 243);
  static Color get unselectedItemColor => Color(0xff687389);
  static Color get selectedItemColor => Color(0xfff48bc4);
  static List<Color> gradientColors = [
    Color(0xfffcaac4),
    Color(0xfff48bc4),
    Color(0xffa23bae),
  ];

  static set background(Color color) => _background = color;
  static set primary(Color color) => _primary = color;
  static set secondaryPrimary(Color color) => _secondaryPrimary = color;
}
