import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyquotes/Widgets/FadeInDown.dart';
import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/view/errorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/globales.dart';
import '../../core/utils/sharedAssets.dart';
import '../../view-model/TabsCubit/popularCubit.dart';
import '../../view-model/TabsCubit/popularStates.dart';
import '../defaultContainer.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularCubit, PopularStates>(
      listener: (BuildContext context, PopularStates state) {},
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
                          child: CarouselSlider.builder(
                            itemCount: cubit.popularQuotes.length,
                            options: CarouselOptions(
                              enableInfiniteScroll: false,
                              scrollPhysics:
                                  const AlwaysScrollableScrollPhysics(),
                              //   viewportFraction: 0.8, //longRecatngle
                              viewportFraction: 0.3, //shortRecatngle

                              initialPage: 0,
                              reverse: true,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 2),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.vertical,
                            ),
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return FadeInDown(
                                child: DefaultContainer(
                                  quote: cubit.popularQuotes[itemIndex],
                                  height: height * 0.23,
                                  //   height: height * 0.68, //longRectangle

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
                                          await Share.share(
                                            '“${cubit.popularQuotes[itemIndex].quote}”\n\n- ${cubit.popularQuotes[itemIndex].author}\n\n\n$sharingMyGit',
                                            subject: 'Check Today\'s Quote',
                                          );
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.gradientColors[2],
                                          child: const Icon(
                                            Icons.share,
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
