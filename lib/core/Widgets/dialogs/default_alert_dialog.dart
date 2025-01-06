import 'package:dailyquotes/main.dart';

import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/text/app_text_styles.dart';
import '../buttons/default_button.dart';

abstract class DefaultAlertDialog {
  static AlertDialog Info({
    required IconData icon,
    String? buttonText,
    required Function() onOkClicked,
    required String content,
    required BuildContext context,
  }) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: AppColorsProvider.of(context).appColors.textBG,
        size: 45.sp,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        DefaultButton(
          height: 35.h,
          raduis: 20.r,
          width: 70.w,
          onClicked: onOkClicked,
          child: Text(
            buttonText ?? 'OK',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14MediumABeeZee.copyWith(
              color: AppColorsProvider.of(context).appColors.textBG,
            ),
          ),
        ),
      ],
      backgroundColor: AppColorsProvider.of(context).appColors.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: AppTextStyles.font14MediumABeeZee.copyWith(
              color: AppColorsProvider.of(context).appColors.textBG,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
    );
  }

  static AlertDialog Confirm({
    required IconData icon,
    String? buttonText,
    required Function() onNoClicked,
    required Function() onYesClicked,
    required String content,
    required BuildContext context,
  }) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: AppColorsProvider.of(context).appColors.textBG,
        size: 45.sp,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        DefaultButton(
          backgroundColor:
              AppColorsProvider.of(context).appColors.secondaryPrimary,
          height: 35.h,
          raduis: 20.r,
          width: 100.w,
          onClicked: onYesClicked,
          child: Text(
            buttonText ?? 'Yes',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14MediumABeeZee.copyWith(
              color: AppColorsProvider.of(context).appColors.textBG,
            ),
          ),
        ),
        DefaultButton(
          backgroundColor:
              AppColorsProvider.of(context).appColors.secondaryPrimary,
          height: 35.h,
          raduis: 20.r,
          width: 100.w,
          onClicked: onNoClicked,
          child: Text(
            buttonText ?? 'No',
            style: AppTextStyles.font14MediumABeeZee.copyWith(
              color: AppColorsProvider.of(context).appColors.textBG,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
      backgroundColor: AppColorsProvider.of(context).appColors.background,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content,
            style: AppTextStyles.font14MediumABeeZee.copyWith(
              color: AppColorsProvider.of(context).appColors.textBG,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
    );
  }
}
