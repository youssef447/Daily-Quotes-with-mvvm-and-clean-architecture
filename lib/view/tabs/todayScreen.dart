import 'dart:ui';

import 'package:dailyquotes/Widgets/FadeInDown.dart';
import 'package:dailyquotes/core/utils/defaultAwesomeDialog.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayStates.dart';

import 'package:dailyquotes/view/errorScreen.dart';
import 'package:dailyquotes/view/defaultContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/appColors.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodayCubit, TodayStates>(listener: (context, state) {
      if (state is AddToPopularSuccessState) {
        AwesomeDialogUtil.sucess(
            context: context, body: 'Quote Added To Favorite', title: 'Done');
      }
      if (state is AddToPopularErrorState) {
        AwesomeDialogUtil.error(
            context: context,
            body: 'Error Adding Quote To Favorite',
            title: 'Filed');
      }
    }, builder: (context, state) {
      var cubit = TodayCubit.get(context);

      return state is GetTodayQuoteLoadingState
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : state is GetTodayQuoteErrorState
              ? ErrorScreen(
                  errMsg: state.err,
                  retry: () {
                    cubit.getTodayQuote();
                  })
              : Stack(
                  children: [
                    Center(
                      child: FadeInDown(
                        child: DefaultContainer(
                          quote: todayQuote,
                          height: height * 0.68, //longRectangle
                          //   height: height * 0.23, //shortRectangle
                          stackButtons: [
                            Positioned(
                              right: 50,
                              bottom: -15,
                              child: InkWell(
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () {
                                  todayQuote.fav == false
                                      ? cubit.addToPopular(todayQuote)
                                      : cubit.removeFromPopular(todayQuote);
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.gradientColors[2],
                                  child: Icon(
                                    todayQuote.fav == false
                                        ? Icons.favorite_outline
                                        : Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -15,
                              child: InkWell(
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () async {
                                  await Share.share(
                                      '“${todayQuote.quote}”\n\n- ${todayQuote.author}\n\n\n$sharingMyGit');
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.gradientColors[2],
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    state is AddToPopularLoadingState
                        ? BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 3.0,
                              sigmaY: 3.0,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
    });
  }
}
