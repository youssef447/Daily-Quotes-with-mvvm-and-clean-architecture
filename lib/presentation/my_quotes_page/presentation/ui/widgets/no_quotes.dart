part of '../pages/my_quotes_page.dart';

class NoQuotes extends StatelessWidget {
  const NoQuotes({
    super.key,
    required this.controller,
  });

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                overlayColor: WidgetStatePropertyAll<Color>(
                  Colors.transparent,
                ),
                onTap: () {
                  DefaultBottomSheet.Default(
                    context: context,
                    transitionAnimationController: controller,
                    child: AddEditQuoteSheet(),
                  );
                },
                child: Lottie.asset(
                  AnimsAssets.add,
                  width: 200.w,
                  height: 200.h,
                  frameRate: const FrameRate(120),
                ),
              ),
              Text(
                'Tap To Add Your First Quote',
                style: AppTextStyles.font14MediumABeeZeePrimary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
