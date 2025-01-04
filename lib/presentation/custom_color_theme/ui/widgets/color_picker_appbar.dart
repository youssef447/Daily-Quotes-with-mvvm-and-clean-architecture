part of '../pages/color_picker_page.dart';

class ColorPickerAppbar extends StatelessWidget {
  const ColorPickerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      delay: 20,
      leftToRight: true,
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: SvgPicture.asset(ImageAssets.arrowBack,
                width: 24.w, height: 24.h, color: AppColors.textBG),
          ),
          Expanded(
            child: Text(
              'Customize App Theme',
              style: AppTextStyles.font16MediumAmitaPrimary
                  .copyWith(color: AppColors.textBG),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
