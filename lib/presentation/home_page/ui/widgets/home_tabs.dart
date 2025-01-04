part of '../pages/home_page.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(buildWhen: (previous, current) {
      return current is ChangeTabState;
    }, builder: (context, value) {
      final cubit = BlocProvider.of<HomeCubit>(context);
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(QuoteTab.values.length, (index) {
          final bool selected = cubit.currentTab == QuoteTab.values[index];
          return Padding(
            padding: EdgeInsetsDirectional.only(
                end: index == QuoteTab.values.length - 1 ? 0 : 30.w),
            child: InkWell(
              overlayColor: WidgetStatePropertyAll<Color>(
                Colors.transparent,
              ),
              onTap: () {
                cubit.changeTab(QuoteTab.values[index]);
              },
              child: AnimatedDefaultTextStyle(
                curve: Curves.decelerate,
                style: AppTextStyles.font14MediumABeeZee.copyWith(
                  color: selected
                      ? AppColors.selectedItemColor
                      : AppColors.unselectedItemColor,
                  fontWeight: selected
                      ? AppFontWeights.extraBold
                      : AppFontWeights.medium,
                ),
                duration: const Duration(milliseconds: 300),
                child: Text(
                  QuoteTab.values[index].getName,
                ),
              ),
            ),
          );
        })),
      );
    });
  }
}
