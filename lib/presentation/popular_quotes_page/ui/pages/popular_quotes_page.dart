import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/widgets/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/loading/default_loading_indicator.dart';
import '../../../../core/widgets/sliders/default_carousel_slider.dart';
import '../../../../core/animations/fade_In_down_animation.dart';
import '../../../../core/widgets/dialogs/default_awesome_dialog.dart';

import 'package:dailyquotes/core/constants/assets.dart';
import '../../controller/popular_cubit.dart';
import '../../controller/popular_states.dart';
import '../../../../core/widgets/cards/quote_card.dart';

class PopularQuotesPage extends StatelessWidget {
  const PopularQuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularCubit()
        ..getPopularQuotes()
        ..getTodayQuote(context),
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
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return FadeInDownAnimation(
                                  child: QuoteCard(
                                    quote: cubit.popularQuotes[itemIndex],
                                    stackButtons: [
                                      PositionedDirectional(
                                        end: 50.w,
                                        bottom: -15.h,
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
                                            radius: 20.r,
                                            backgroundColor:
                                                AppColors.secondaryPrimary,
                                            child: const Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -15.h,
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
                                            radius: 20.r,
                                            backgroundColor:
                                                AppColors.secondaryPrimary,
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