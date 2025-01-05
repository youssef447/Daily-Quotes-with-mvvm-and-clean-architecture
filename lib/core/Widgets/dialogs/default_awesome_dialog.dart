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
  }) {
    AwesomeDialog(
      context: context,
      dialogBorderRadius: BorderRadius.circular(30.r),
      body: Text(
        body,
        style: AppTextStyles.font14MediumABeeZee.copyWith(
          color: AppColorsProvider.of(context).appColors.primary,
        ),
      ),
      title: title,
      dialogType: DialogType.success,
      padding: const EdgeInsets.all(15),
      dialogBackgroundColor: AppColorsProvider.of(context).appColors.background,
      btnOkColor: AppColorsProvider.of(context).appColors.primary,
      buttonsTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }

  static error({
    required BuildContext context,
    String? msg,
    required String body,
    required String title,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      dialogBackgroundColor: AppColorsProvider.of(context).appColors.background,
      dialogBorderRadius: BorderRadius.circular(30.r),
      context: context,
      body: msg == null
          ? Text(
              body,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            )
          : Text(
              "$body , $msg",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
      title: title,
      dialogType: DialogType.error,
      btnOkColor: AppColorsProvider.of(context).appColors.defaultAddbtnColor,
      buttonsTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      padding: EdgeInsets.all(15.h),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }
}
