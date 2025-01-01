part of '../pages/home_page.dart';

class CustomTabs extends StatelessWidget {
  const CustomTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(buildWhen: (previous, current) {
      return current is ChangeTabState;
    }, builder: (context, value) {
      final cubit = BlocProvider.of<HomeCubit>(context);
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(QuoteTab.values.length, (index) {
            final bool selected = cubit.currentTab == QuoteTab.values[index];
            return InkWell(
              overlayColor: WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              onTap: () {
                cubit.changeTab(QuoteTab.values[index]);
              },
              child: Text(
                QuoteTab.values[index].getName,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: selected
                          ? AppColors.selectedItemColor
                          : AppColors.unselectedItemColor,
                    ),
              ),
            );
          }));
    });
  }
}
