part of '../pages/color_picker_page.dart';

class ThemeConfirmButtons extends StatelessWidget {
  final CustomColorThemeController cubit;
  const ThemeConfirmButtons({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DefaultButton(
          height: 35.h,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.secondaryPrimary,
          raduis: 20.r,
          width: 120.w,
          onClicked: () {
            cubit.resetTheme(context);
          },
          child: Text(
            'Reset',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14RegularABeeZee
                .copyWith(color: AppColors.icon),
          ),
        ),
        DefaultButton(
          height: 35.h,
          foregroundColor: Colors.white,
          backgroundColor: AppColors.secondaryPrimary,
          raduis: 20.r,
          width: 120.w,
          onClicked: () {
            cubit.changeTheme(context);
          },
          child: Text(
            'Confirm',
            textAlign: TextAlign.center,
            style: AppTextStyles.font14RegularABeeZee
                .copyWith(color: AppColors.icon),
          ),
        ),
      ],
    );
  }
}