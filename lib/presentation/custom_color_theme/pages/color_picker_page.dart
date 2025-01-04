import 'package:dailyquotes/core/helpers/spacing_helper.dart';
import 'package:dailyquotes/core/widgets/animations/scale_animation.dart';
import 'package:dailyquotes/presentation/custom_color_theme/controller/custom_color_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/text/app_text_styles.dart';
import '../../../core/widgets/animations/horizontal_animation.dart';
import '../../../core/widgets/buttons/default_button.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomColorThemeController, dynamic>(
        builder: (context, _) {
      final cubit = context.read<CustomColorThemeController>();
      return Scaffold(
        appBar: AppBar(
          title: SlideAnimation(
            delay: 20,
            leftToRight: true,
            child: Text(
              'Customize App Theme',
              style: AppTextStyles.font16MediumAmitaPrimary,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Primary Color',
                    style: AppTextStyles.font14RegularABeeZee,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(18),
                  ScaleAnimation(
                    delay: 100,
                    child: ColorPicker(
                      colorPickerWidth: 250.w,
                      displayThumbColor: true,
                      pickerColor: AppColors.primary,
                      pickerAreaBorderRadius: BorderRadius.circular(8.r),
                      paletteType: PaletteType.hueWheel,
                      labelTypes: [],
                      onColorChanged: (c) {},
                    ),
                  ),
                  Text(
                    'Secondary Color',
                    style: AppTextStyles.font14RegularABeeZee,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(18),
                  ScaleAnimation(
                    delay: 100,
                    child: ColorPicker(
                      displayThumbColor: true,
                      colorPickerWidth: 250.w,
                      pickerColor: AppColors.secondaryPrimary,
                      pickerAreaBorderRadius: BorderRadius.circular(8.r),
                      paletteType: PaletteType.hueWheel,
                      labelTypes: [],
                      onColorChanged: (c) {},
                    ),
                  ),
                  DefaultButton(
                    height: 35.h,
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.selectedItemColor,
                    raduis: 20.r,
                    width: 70.w,
                    onClicked: () {
                      cubit.changeTheme(context);
                    },
                    child: Text(
                      'CONFIRM',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
