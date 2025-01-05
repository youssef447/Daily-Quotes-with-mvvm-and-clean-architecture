import 'package:dailyquotes/main.dart';

import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../buttons/default_button.dart';

abstract class DefaultAlertDialog {
  static AlertDialog Info({
    required IconData icon,
    Color? iconColor,
    String? buttonText,
    required Function() onOkClicked,
    required TextStyle defaultTextStyle,
    required String content,
    required BuildContext context,
  }) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black,
        size: 45.sp,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        DefaultButton(
          height: 35.h,
          foregroundColor: Colors.white,
          backgroundColor: AppColorsProvider.of(context).appColors.primary,
          raduis: 20.r,
          width: 70.w,
          onClicked: onOkClicked,
          child: Text(
            buttonText ?? 'OK',
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
            style: defaultTextStyle,
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
    Color? iconColor,
    String? buttonText,
    required Function() onNoClicked,
    required Function() onYesClicked,
    required TextStyle defaultTextStyle,
    required String content,
    required BuildContext context,
  }) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black,
        size: 45,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        DefaultButton(
          height: 35.h,
          foregroundColor: Colors.white,
          backgroundColor: AppColorsProvider.of(context).appColors.primary,
          raduis: 20.r,
          width: 100.w,
          onClicked: onYesClicked,
          child: Text(
            buttonText ?? 'Yes',
            textAlign: TextAlign.center,
          ),
        ),
        DefaultButton(
          height: 35.h,
          foregroundColor: Colors.white,
          backgroundColor: AppColorsProvider.of(context).appColors.primary,
          raduis: 20.r,
          width: 100.w,
          onClicked: onNoClicked,
          child: Text(
            buttonText ?? 'No',
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
            style: defaultTextStyle,
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
