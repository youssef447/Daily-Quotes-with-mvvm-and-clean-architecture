import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/core/theme/colors/app_colors.dart';
import 'package:dailyquotes/core/theme/colors/contrast_color_helper.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';
import 'package:dailyquotes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'custom_color_theme_states.dart';

class CustomColorThemeController extends Cubit<CustomColorThemeStates> {
  late final AppColors appColors = AppColors.instance;
  CustomColorThemeController() : super(CustomColorThemeStatesInitial());

  void getTheme() async {
    String? primaryHexColor = await CacheHelper.getData(key: 'primaryColor');

    String? secondaryHexColor =
        await CacheHelper.getData(key: 'secondaryColor');
    String backgroundHexColor =
        await CacheHelper.getData(key: 'backgroundColor') ??
            appColors.background.toHexString();
    setPrimaryColor(primaryHexColor);

    setSecondaryPrimaryColor(secondaryHexColor);
    setGradientColors();
    await setBackgroundColor(backgroundHexColor);

    emit(ConfigThemeStateSuccess());
  }

  setPrimaryColor(String? hexColor) {
    if (hexColor != null) {
      appColors.primary = Color(int.parse(hexColor, radix: 16));
    }
  }

  setGradientColors() {
    appColors.gradientColors = [appColors.primary, appColors.secondaryPrimary];
  }

  setSecondaryPrimaryColor(String? hexColor) {
    if (hexColor != null) {
      appColors.secondaryPrimary = Color(int.parse(hexColor, radix: 16));
    }
  }

  Future<void> setBackgroundColor(String? hexColor) async {
    if (hexColor != null) {
      appColors.background = Color(int.parse(hexColor, radix: 16));
    }
    await FlutterStatusbarcolor.setStatusBarColor(appColors.background);

    await FlutterStatusbarcolor.setNavigationBarColor(appColors.background);
    if (ContrastColorHelper.contrastBGColor(appColors.background) ==
        Colors.white) {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    } else {
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

  //Managed In Cutom Theme Page
  Color? primaryColor;
  Color? secondaryColor;
  Color? background;
  void changeTheme(BuildContext context) async {
    try {
      AppColorsProvider.of(context).appColors.primary =
          primaryColor ?? AppColorsProvider.of(context).appColors.primary;
      AppColorsProvider.of(context).appColors.secondaryPrimary =
          secondaryColor ??
              AppColorsProvider.of(context).appColors.secondaryPrimary;
      AppColorsProvider.of(context).appColors.background =
          background ?? AppColorsProvider.of(context).appColors.background;
      AppColorsProvider.of(context).appColors.gradientColors = [
        AppColorsProvider.of(context).appColors.primary,
        AppColorsProvider.of(context).appColors.secondaryPrimary
      ];
      await CacheHelper.saveData(
          key: 'primaryColor',
          value: AppColorsProvider.of(context).appColors.primary.toHexString());

      if (context.mounted) {
        await CacheHelper.saveData(
            key: 'secondaryColor',
            value: AppColorsProvider.of(context)
                .appColors
                .secondaryPrimary
                .toHexString());
      }

      if (context.mounted) {
        await CacheHelper.saveData(
            key: 'backgroundColor',
            value: AppColorsProvider.of(context)
                .appColors
                .background
                .toHexString());
      }

      if (context.mounted) {
        await setSystemBarAndNavColors(context);
      }

      emit(ConfigThemeStateSuccess());

      if (context.mounted) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: 'Theme Changed Successfully',
          title: 'Success',
          onDismissCallback: (type) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      }
    } catch (e) {
      emit(ConfigThemeStateError(e.toString()));
    }
  }

  void resetTheme(BuildContext context) async {
    try {
      AppColorsProvider.of(context).appColors.background =
          const Color(0xff303b4d);
      AppColorsProvider.of(context).appColors.primary = const Color(0xfff48bc4);
      AppColorsProvider.of(context).appColors.secondaryPrimary =
          const Color(0xffa23bae);
      AppColorsProvider.of(context).appColors.gradientColors =
          AppColorsProvider.of(context).appColors.gradientColors = [
        AppColorsProvider.of(context).appColors.primary,
        AppColorsProvider.of(context).appColors.secondaryPrimary
      ];
      await CacheHelper.removeData(key: 'primaryColor');
      await CacheHelper.removeData(key: 'secondaryColor');
      await CacheHelper.removeData(key: 'backgroundColor');

      if (context.mounted) {
        await setSystemBarAndNavColors(context);
      }

      emit(ConfigThemeStateSuccess());
      if (context.mounted) {
        AwesomeDialogUtil.sucess(
          context: context,
          body: 'Theme Reset Successfully',
          title: 'Success',
          onDismissCallback: (type) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      }
    } catch (e) {
      emit(ConfigThemeStateError(e.toString()));
    }
  }

  Future<void> setSystemBarAndNavColors(BuildContext context) async {
    await FlutterStatusbarcolor.setStatusBarColor(
        AppColorsProvider.of(context).appColors.background);

    if (context.mounted) {
      await FlutterStatusbarcolor.setNavigationBarColor(
          AppColorsProvider.of(context).appColors.background);
    }
    if (context.mounted) {
      if (ContrastColorHelper.contrastBGColor(
              AppColorsProvider.of(context).appColors.background) ==
          Colors.white) {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      }
    }
  }
}
