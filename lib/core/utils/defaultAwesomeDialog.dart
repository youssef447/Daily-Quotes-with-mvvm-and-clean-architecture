import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import 'appColors.dart';

class AwesomeDialogUtil {
  static sucess({
    required BuildContext context,
    required String body,
    required String title,
    Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogBorderRadius: BorderRadius.circular(30),
      body: Text(body,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: AppColors.selectedItemColor,
              )),
      title: "VERIFICATION",
      dialogType: DialogType.success,
      padding: const EdgeInsets.all(15),
      dialogBackgroundColor: AppColors.defaultColor,
      btnOkColor: AppColors.selectedItemColor,
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
      dialogBackgroundColor: AppColors.defaultColor,
      dialogBorderRadius: BorderRadius.circular(30),
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
      btnOkColor: AppColors.defaultAddbtnColor,
      buttonsTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
      padding: const EdgeInsets.all(15),
      btnOkOnPress: btnOkOnPress ?? () {},
    ).show();
  }
}
