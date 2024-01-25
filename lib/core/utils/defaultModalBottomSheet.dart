import 'package:flutter/material.dart';

import 'appColors.dart';
import 'globales.dart';

class DefaultModalBottomSheet {
  static Default(
      {required BuildContext context,
      AnimationController? transitionAnimationController,
      required Widget child}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.unselectedItemColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
      ),
      transitionAnimationController: transitionAnimationController,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).viewInsets.bottom * 0.04),
        ),
        child: SizedBox(
          height: height * 0.85,
          child: child,
        ),
      ),
    );
  }
}
