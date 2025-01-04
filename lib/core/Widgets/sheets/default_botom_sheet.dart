import 'package:dailyquotes/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors/app_colors.dart';

abstract class DefaultBottomSheet {
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
          topRight: Radius.circular(35.r),
          topLeft: Radius.circular(35.r),
        ),
      ),
      transitionAnimationController: transitionAnimationController,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).viewInsets.bottom * 0.04),
        ),
        child: SizedBox(
          height: context.height * 0.85,
          child: child,
        ),
      ),
    );
  }
}
