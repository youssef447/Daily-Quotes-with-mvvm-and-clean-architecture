part of '../pages/my_quotes_page.dart';

class NoQuotes extends StatelessWidget {
  const NoQuotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                overlayColor: const WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
                onTap: () {
                  DefaultBottomSheet.Default(
                    context: context,
                    child: const AddEditQuoteSheet(),
                  );
                },
                child: Lottie.asset(
                  AnimsAssets.add,
                  width: 200.w,
                  height: 200.h,
                  frameRate: const FrameRate(120),
                ),
              ),
              verticalSpace(15),
              Text(
                'Tap To Add Your First Quote',
                style: AppTextStyles.font20MediumABeeZeePrimary.copyWith(
                    color: AppColorsProvider.of(context).appColors.textBG),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
