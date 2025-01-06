import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AwesomeDialogUtil {
  static sucess({
    required BuildContext context,
    required String body,
    required String title,
    Function()? btnOkOnPress,
    Function(DismissType)? onDismissCallback,
  }) {
    AwesomeDialog(
      context: context,
      autoHide: const Duration(seconds: 2),
      onDismissCallback: onDismissCallback,
      dialogBorderRadius: BorderRadius.circular(30.r),
      body: Text(
        body,
        style: AppTextStyles.font14MediumABeeZee.copyWith(
          color: AppColorsProvider.of(context).appColors.textBG,
        ),
      ),
      title: title,
      dialogType: DialogType.success,
      padding: EdgeInsets.all(15.h),
      dialogBackgroundColor: AppColorsProvider.of(context).appColors.background,
      btnOkColor: AppColorsProvider.of(context).appColors.secondaryPrimary,
      buttonsTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColorsProvider.of(context).appColors.icon,
          ),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  static error({
    required BuildContext context,
    String? msg,
    required String body,
    required String title,
    Function(DismissType)? onDismissCallback,
  }) {
    AwesomeDialog(
      dialogBackgroundColor: AppColorsProvider.of(context).appColors.background,
      dialogBorderRadius: BorderRadius.circular(30.r),
      autoHide: const Duration(seconds: 2),
      context: context,
      body: msg == null
          ? Text(
              body,
              style: AppTextStyles.font14MediumABeeZee.copyWith(
                color: AppColorsProvider.of(context).appColors.textBG,
              ),
            )
          : Text(
              "$body , $msg",
              style: AppTextStyles.font14MediumABeeZee.copyWith(
                color: AppColorsProvider.of(context).appColors.textBG,
              ),
            ),
      title: title,
      dialogType: DialogType.error,
      btnOkColor: AppColorsProvider.of(context).appColors.defaultAddbtnColor,
      buttonsTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColorsProvider.of(context).appColors.icon,
          ),
      padding: EdgeInsets.all(15.h),
    ).show();
  }
}
