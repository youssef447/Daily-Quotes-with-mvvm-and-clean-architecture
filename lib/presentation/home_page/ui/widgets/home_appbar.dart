part of '../pages/home_page.dart';

class HomeAppbar extends StatelessWidget {
  final Function() longRectOnTap, squareOnTap;
  final Color longColor, squareColor;
  final HomeCubit cubit;
  const HomeAppbar({
    super.key,
    required this.longRectOnTap,
    required this.squareOnTap,
    required this.longColor,
    required this.squareColor,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          Text(
            'Quotez',
            style: AppTextStyles.font18MediumAmita.copyWith(
                color: AppColorsProvider.of(context).appColors.textBG),
          ),
          const Spacer(),
          InkWell(
            overlayColor: const WidgetStatePropertyAll<Color>(
              Colors.transparent,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => DefaultAlertDialog.Confirm(
                        context: context,
                        icon: Icons.notification_important_outlined,
                        onYesClicked: () {
                          cubit.changeNotification();
                        },
                        onNoClicked: () {
                          Navigator.of(context).pop();
                        },
                        content: noitificationsEnabled
                            ? 'Do You Wish To Disable Notifications'
                            : 'Do You Wish To Enable Notifications',
                      ));
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                noitificationsEnabled
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                color: noitificationsEnabled
                    ? AppColorsProvider.of(context).appColors.primary
                    : AppColorsProvider.of(context).appColors.textBG,
                size: 25.sp,
              ),
            ),
          ),
          horizontalSpace(16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: longRectOnTap,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                ImageAssets.rectangle,
                color: longColor,
                width:
                    longColor == AppColorsProvider.of(context).appColors.primary
                        ? 24.w
                        : 18.w,
                height:
                    longColor == AppColorsProvider.of(context).appColors.primary
                        ? 24.h
                        : 18.h,
              ),
            ),
          ),
          horizontalSpace(16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: squareOnTap,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset(
                ImageAssets.card,
                color: squareColor,
                width: squareColor ==
                        AppColorsProvider.of(context).appColors.primary
                    ? 24.w
                    : 18.w,
                height: squareColor ==
                        AppColorsProvider.of(context).appColors.primary
                    ? 24.h
                    : 18.h,
              ),
            ),
          ),
          horizontalSpace(16),
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.navigate(AppRoutes.customColorTheme);
              },
              child: SvgPicture.asset(
                ImageAssets.palette,
                width: 28.w,
                height: 28.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
