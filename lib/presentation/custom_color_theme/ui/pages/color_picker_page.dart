import 'package:dailyquotes/core/constants/assets.dart';
import 'package:dailyquotes/core/helpers/spacing_helper.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/widgets/animations/horizontal_animation.dart';
import 'package:dailyquotes/core/widgets/animations/scale_animation.dart';
import 'package:dailyquotes/core/widgets/buttons/default_button.dart';
import 'package:dailyquotes/main.dart';
import 'package:dailyquotes/presentation/custom_color_theme/controller/custom_color_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

part '../widgets/color_picker_appbar.dart';
part '../widgets/theme_confirm_buttons.dart';

class ColorPickerPage extends StatelessWidget {
  const ColorPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomColorThemeController, dynamic>(
        builder: (context, _) {
      final cubit = context.read<CustomColorThemeController>();
      return Scaffold(
        backgroundColor: AppColorsProvider.of(context).appColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ColorPickerAppbar(),
                  verticalSpace(18),
                  Text(
                    'Primary Color',
                    style: AppTextStyles.font14RegularABeeZee.copyWith(
                        color: AppColorsProvider.of(context).appColors.textBG),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(18),
                  ScaleAnimation(
                    delay: 100,
                    child: ColorPicker(
                      colorPickerWidth: 250.w,
                      displayThumbColor: true,
                      pickerColor:
                          AppColorsProvider.of(context).appColors.primary,
                      pickerAreaBorderRadius: BorderRadius.circular(8.r),
                      paletteType: PaletteType.hueWheel,
                      labelTypes: [],
                      onColorChanged: (c) {
                        cubit.primaryColor = c;
                      },
                    ),
                  ),
                  Text(
                    'Secondary Color',
                    style: AppTextStyles.font14RegularABeeZee.copyWith(
                        color: AppColorsProvider.of(context).appColors.textBG),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(18),
                  ScaleAnimation(
                    delay: 100,
                    child: ColorPicker(
                      displayThumbColor: true,
                      colorPickerWidth: 250.w,
                      pickerColor: AppColorsProvider.of(context)
                          .appColors
                          .secondaryPrimary,
                      pickerAreaBorderRadius: BorderRadius.circular(8.r),
                      paletteType: PaletteType.hueWheel,
                      labelTypes: [],
                      onColorChanged: (c) {
                        cubit.secondaryColor = c;
                      },
                    ),
                  ),
                  Text(
                    'Background Color',
                    style: AppTextStyles.font14RegularABeeZee.copyWith(
                        color: AppColorsProvider.of(context).appColors.textBG),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(18),
                  ScaleAnimation(
                    delay: 100,
                    child: ColorPicker(
                      displayThumbColor: true,
                      colorPickerWidth: 250.w,
                      pickerColor:
                          AppColorsProvider.of(context).appColors.background,
                      pickerAreaBorderRadius: BorderRadius.circular(8.r),
                      paletteType: PaletteType.hueWheel,
                      labelTypes: [],
                      onColorChanged: (c) {
                        cubit.background = c;
                      },
                    ),
                  ),
                  verticalSpace(12),
                  ThemeConfirmButtons(
                    cubit: cubit,
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
