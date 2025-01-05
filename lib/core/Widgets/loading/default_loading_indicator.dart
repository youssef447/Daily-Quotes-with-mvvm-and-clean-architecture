import 'package:dailyquotes/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  const DefaultLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.w,
        height: 50.h,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              AppColorsProvider.of(context).appColors.primary),
          backgroundColor: Colors.white60,
          strokeWidth: 2.0,
        ),
      ),
    );
  }
}
