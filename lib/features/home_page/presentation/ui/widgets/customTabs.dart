part of '../pages/home_page.dart';

class CustomTabs extends StatelessWidget {
  final Function() todayOnTap, popularOnTap, randomOnTap, myQuotesOnTap;
  final Color todayColor, popularColor, randomColor, myQuotesColor;
  const CustomTabs({
    super.key,
    required this.todayOnTap,
    required this.popularOnTap,
    required this.randomOnTap,
    required this.todayColor,
    required this.popularColor,
    required this.randomColor,
    required this.myQuotesColor,
    required this.myQuotesOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          overlayColor: WidgetStatePropertyAll<Color>(
            Colors.transparent,
          ),
          onTap: todayOnTap,
          child: Text(
            'Today',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: todayColor,
                ),
          ),
        ),
        InkWell(
          overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          onTap: popularOnTap,
          child: Text(
            'Popular',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: popularColor,
                ),
          ),
        ),
        InkWell(
          overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          onTap: randomOnTap,
          child: Text(
            'Random',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: randomColor,
                ),
          ),
        ),
        InkWell(
          overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
          onTap: myQuotesOnTap,
          child: Text(
            'My Quotes',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: myQuotesColor,
                ),
          ),
        ),
      ],
    );
  }
}
