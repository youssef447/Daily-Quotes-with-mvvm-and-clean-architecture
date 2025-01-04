import 'package:dailyquotes/core/services/Network/local/cach_helper.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/theme/colors/app_colors.dart';

class CustomColorThemeController extends Cubit {
  CustomColorThemeController() : super(0);

  Color? primaryColor;
  Color? secondaryColor;

  void getTheme() async {
    String primaryHexColor = await CacheHelper.getData(key: 'primaryColor') ??
        AppColors.primary.toHexString();
    print('a7a $primaryHexColor');
    String secondaryHexColor =
        await CacheHelper.getData(key: 'secondaryColor') ??
            AppColors.secondaryPrimary.toHexString();
    AppColors.primary = Color(int.parse(primaryHexColor, radix: 16));
    AppColors.secondaryPrimary = Color(int.parse(secondaryHexColor, radix: 16));
  }

  void changeTheme(BuildContext context) async {
    AppColors.primary = primaryColor ?? AppColors.primary;
    AppColors.secondaryPrimary = secondaryColor ?? AppColors.secondaryPrimary;
    await CacheHelper.saveData(
        key: 'primaryColor', value: AppColors.primary.toHexString());
    await CacheHelper.saveData(
        key: 'secondaryColor', value: AppColors.secondaryPrimary.toHexString());
    emit(state);
    Navigator.of(context).pop();
    AwesomeDialogUtil.sucess(
        context: context, body: 'Theme Changed Successfully', title: 'Success');
  }
}
