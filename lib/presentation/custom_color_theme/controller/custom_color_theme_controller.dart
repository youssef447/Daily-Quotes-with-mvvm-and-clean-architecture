import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import '../../../core/theme/colors/app_colors.dart';
import 'custom_color_theme_states.dart';

class CustomColorThemeController extends Cubit<CustomColorThemeStates> {
  CustomColorThemeController() : super(CustomColorThemeStatesInitial());

  void getTheme() async {
    String? primaryHexColor = await CacheHelper.getData(key: 'primaryColor');

    String? secondaryHexColor =
        await CacheHelper.getData(key: 'secondaryColor');
    String backgroundHexColor =
        await CacheHelper.getData(key: 'backgroundColor') ??
            AppColors.background.toHexString();
    setPrimaryColor(primaryHexColor);
    //AppColors.gradientColors = [Color(int.parse(primaryHexColor, radix: 16))];

    setSecondaryPrimaryColor(secondaryHexColor);
    setGradientColors();
    await setBackgroundColor(backgroundHexColor);

    emit(ConfigThemeStateSuccess());
  }

  setPrimaryColor(String? hexColor) {
    if (hexColor != null) {
      AppColors.primary = Color(int.parse(hexColor, radix: 16));
    }
  }

  setGradientColors() {
    AppColors.gradientColors = [AppColors.primary, AppColors.secondaryPrimary];
  }

  setSecondaryPrimaryColor(String? hexColor) {
    if (hexColor != null) {
      AppColors.secondaryPrimary = Color(int.parse(hexColor, radix: 16));
    }
  }

  Future<void> setBackgroundColor(String? hexColor) async {
    if (hexColor != null) {
      AppColors.background = Color(int.parse(hexColor, radix: 16));
    }
    await FlutterStatusbarcolor.setStatusBarColor(AppColors.background);

    await FlutterStatusbarcolor.setNavigationBarColor(AppColors.background);
  }

  //Managed In Cutom Theme Page
  Color? primaryColor;
  Color? secondaryColor;
  Color? background;
  void changeTheme(BuildContext context) async {
    AppColors.primary = primaryColor ?? AppColors.primary;
    AppColors.secondaryPrimary = secondaryColor ?? AppColors.secondaryPrimary;
    AppColors.background = background ?? AppColors.background;
    AppColors.gradientColors = [AppColors.primary, AppColors.secondaryPrimary];
    await CacheHelper.saveData(
        key: 'primaryColor', value: AppColors.primary.toHexString());
    await CacheHelper.saveData(
        key: 'secondaryColor', value: AppColors.secondaryPrimary.toHexString());
    await CacheHelper.saveData(
        key: 'backgroundColor', value: AppColors.background.toHexString());

    await FlutterStatusbarcolor.setStatusBarColor(AppColors.background);

    await FlutterStatusbarcolor.setNavigationBarColor(AppColors.background);

    emit(ConfigThemeStateSuccess());
    AwesomeDialogUtil.sucess(
        context: context, body: 'Theme Changed Successfully', title: 'Success');
    Navigator.of(context).pop();
  }

  void resetTheme(BuildContext context) async {
    AppColors.background = Color(0xff303b4d);
    AppColors.primary = Color(0xfff48bc4);
    AppColors.secondaryPrimary = Color(0xffa23bae);
    AppColors.gradientColors = AppColors.gradientColors = [
      AppColors.primary,
      AppColors.secondaryPrimary
    ];
    await CacheHelper.removeData(key: 'primaryColor');
    await CacheHelper.removeData(key: 'secondaryColor');
    await CacheHelper.removeData(key: 'backgroundColor');

    await FlutterStatusbarcolor.setStatusBarColor(AppColors.background);

    await FlutterStatusbarcolor.setNavigationBarColor(AppColors.background);
    emit(ConfigThemeStateSuccess());
    AwesomeDialogUtil.sucess(
        context: context, body: 'Theme Reset Successfully', title: 'Success');
  }
}
