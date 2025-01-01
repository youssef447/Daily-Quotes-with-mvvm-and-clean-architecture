import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Vertical spacing
SizedBox verticalSpace(double height) {
  return SizedBox(
    height: height.h,
  );
}

// Horizontal spacing
SizedBox horizontalSpace(double width) {
  return SizedBox(
    width: width.w,
  );
}
