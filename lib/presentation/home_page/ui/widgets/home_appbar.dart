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
            style: AppTextStyles.font18MediumAmita,
          ),
          const Spacer(),
          InkWell(
            overlayColor: WidgetStatePropertyAll<Color>(
              Colors.transparent,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => DefaultAlertDialog.Confirm(
                        icon: Icons.notification_important_outlined,
                        iconColor: AppColors.selectedItemColor,
                        onYesClicked: () {
                          cubit.changeNotification();
                        },
                        onNoClicked: () {
                          Navigator.of(context).pop();
                        },
                        defaultTextStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
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
                    ? AppColors.selectedItemColor
                    : Colors.white,
                size: 30.sp,
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
                width: longColor == AppColors.selectedItemColor ? 24.w : 18.w,
                height: longColor == AppColors.selectedItemColor ? 24.h : 18.h,
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
                width: squareColor == AppColors.selectedItemColor ? 24.w : 18.w,
                height:
                    squareColor == AppColors.selectedItemColor ? 24.h : 18.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}