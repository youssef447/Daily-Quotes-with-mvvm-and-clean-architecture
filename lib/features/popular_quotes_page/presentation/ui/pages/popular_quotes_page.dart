import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/Widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/Widgets/loading/default_loading_indicator.dart';
import '../../../../../core/Widgets/sliders/default_carousel_slider.dart';
import '../../../../../core/animations/fade_In_down_animation.dart';
import '../../../../../core/Widgets/dialogs/default_awesome_dialog.dart';
import '../../../../../core/enums/card_shape.dart';
import '../../../../../core/utils/globales.dart';
import 'package:dailyquotes/core/constants/assets.dart';
import '../../../../home_page/presentation/controller/home_cubit.dart';
import '../../controller/popular_cubit.dart';
import '../../controller/popular_states.dart';
import '../../../../../core/Widgets/cards/quote_card.dart';

class PopularQuotesPage extends StatelessWidget {
  const PopularQuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularCubit()..getPopularQuotes(),
      child: BlocConsumer<PopularCubit, PopularStates>(
        listener: (BuildContext context, PopularStates state) {
          if (state is RemoveFromPopularErrorState) {
            AwesomeDialogUtil.error(
              context: context,
              body: 'Error removing Quote from Favorite',
              title: 'Failed',
            );
          }
          if (state is SharingQuoteErrorState) {
            AwesomeDialogUtil.error(
              context: context,
              body: 'Error Sharing Quote, ${state.err} please try again',
              title: 'Failed',
            );
          }
        },
        builder: (context, state) {
          var cubit = PopularCubit.get(context);
          final isRectangle =
              context.read<HomeCubit>().cardShape == CardShape.rectangle;

          return RefreshIndicator(
            backgroundColor: AppColors.background,
            color: AppColors.gradientColors[1],
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              return await cubit.getPopularQuotes();
            },
            child: cubit.popularQuotes.isEmpty
                ? CustomScrollView(
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
                              Text(
                                'No Quotes Added Yet',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: AppColors.selectedItemColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ])
                : state is GetPopularLoadingState
                    ? const DefaultLoadingIndicator()
                    : state is GetPopularErrorState
                        ? CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              ErrorPage(
                                  errMsg: state.err,
                                  retry: () async {
                                    await cubit.getPopularQuotes();
                                  }),
                            ],
                          )
                        : SizedBox(
                            height: double.infinity,
                            child: DefaultCarouselSlider(
                              itemCount: cubit.popularQuotes.length,
                              viewPortFraction: isRectangle ? 0.8 : 0.3,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return FadeInDownAnimation(
                                  child: QuoteCard(
                                    quote: cubit.popularQuotes[itemIndex],
                                    height: isRectangle
                                        ? height * 0.68
                                        : height * 0.23,
                                    stackButtons: [
                                      Positioned(
                                        right: 50,
                                        bottom: -15,
                                        child: InkWell(
                                          overlayColor:
                                              WidgetStatePropertyAll<Color>(
                                            Colors.transparent,
                                          ),
                                          onTap: () async {
                                            await cubit.removeFromPopular(
                                              cubit.popularQuotes[itemIndex],
                                            );
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.gradientColors[2],
                                            child: const Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -15,
                                        child: InkWell(
                                          overlayColor:
                                              WidgetStatePropertyAll<Color>(
                                            Colors.transparent,
                                          ),
                                          onTap: () async {
                                            await cubit.shareQuote(
                                                cubit.popularQuotes[itemIndex]);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.gradientColors[2],
                                            child: const FaIcon(
                                              FontAwesomeIcons.share,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
          );
        },
      ),
    );
  }
}
