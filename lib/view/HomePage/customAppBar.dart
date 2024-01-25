part of 'homeScreen.dart';

class CustomAppBar extends StatelessWidget {
  final Function() longRectOnTap, squareOnTap;
  final Color longColor, squareColor;
  final HomeCubit cubit;
  const CustomAppBar({
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
            style: Theme.of(context).textTheme.titleLarge!,
          ),
          const Spacer(),
          InkWell(
            overlayColor: MaterialStateProperty.all<Color>(
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
            child: Icon(
              noitificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: noitificationsEnabled
                  ? AppColors.selectedItemColor
                  : Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            onTap: longRectOnTap,
            child: Icon(
              Icons.book_online_sharp,
              color: longColor,
            ),
          ),
          InkWell(
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            onTap: squareOnTap,
            child: Icon(
              Icons.rectangle,
              color: squareColor,
            ),
          ),
        ],
      ),
    );
  }
}
