import 'package:dailyquotes/Widgets/FadeInDown.dart';
import 'package:dailyquotes/Widgets/defaultCarouselSlider.dart';
import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/view/errorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/defaultAwesomeDialog.dart';
import '../../core/utils/globales.dart';
import '../../core/utils/sharedAssets.dart';
import '../../view-model/TabsCubit/popularCubit.dart';
import '../../view-model/TabsCubit/popularStates.dart';
import '../defaultContainer.dart';

class PopularScreen extends StatelessWidget {
  final bool longRectangle;
  const PopularScreen({super.key, required this.longRectangle});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularCubit, PopularStates>(
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
          backgroundColor: AppColors.defaultColor,
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
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is GetPopularErrorState
                      ? CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            ErrorScreen(
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
                            viewPortFraction: longRectangle ? 0.8 : 0.3,
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return FadeInDown(
                                child: DefaultContainer(
                                  quote: cubit.popularQuotes[itemIndex],
                                  height: longRectangle
                                      ? height * 0.68
                                      : height * 0.23,
                                  stackButtons: [
                                    Positioned(
                                      right: 50,
                                      bottom: -15,
                                      child: InkWell(
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
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
                                            MaterialStateProperty.all<Color>(
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
    );
  }
}
