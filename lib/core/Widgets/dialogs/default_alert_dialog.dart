import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:flutter/Material.dart';

import '../buttons/default_button.dart';
import '../../utils/utils.dart';

abstract class DefaultAlertDialog {
  static AlertDialog Info({
    required IconData icon,
    Color? iconColor,
    String? buttonText,
    required Function() onOkClicked,
    required TextStyle defaultTextStyle,
    required String content,
  }) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black,
        size: 45,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        DefaultButton(
          height: 35,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.selectedItemColor,
          raduis: 20,
          width: width * 0.5 * 0.5,
          onClicked: onOkClicked,
          child: Text(
            buttonText ?? 'OK',
            textAlign: TextAlign.center,
          ),
        ),
      ],
      backgroundColor: AppColors.defaultColor,
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
        borderRadius: BorderRadius.circular(25),
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
          height: 35,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.selectedItemColor,
          raduis: 20,
          width: width * 0.5 * 0.5,
          onClicked: onYesClicked,
          child: Text(
            buttonText ?? 'Yes',
            textAlign: TextAlign.center,
          ),
        ),
        DefaultButton(
          height: 35,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.selectedItemColor,
          raduis: 20,
          width: width * 0.5 * 0.5,
          onClicked: onNoClicked,
          child: Text(
            buttonText ?? 'No',
            textAlign: TextAlign.center,
          ),
        ),
      ],
      backgroundColor: AppColors.defaultColor,
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
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
