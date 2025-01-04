part of '../pages/popular_quotes_page.dart';

class NoPopularQuotesWidget extends StatelessWidget {
  const NoPopularQuotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AnimsAssets.fav,
                  frameRate: const FrameRate(120),
                  repeat: false,
                ),
                Text('No Quotes Added Yet',
                    style: AppTextStyles.font20MediumABeeZeePrimary),
              ],
            ),
          ),
        ]);
  }
}
