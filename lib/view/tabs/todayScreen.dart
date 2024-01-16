import 'dart:ui';

import 'package:dailyquotes/core/utils/defaultAwesomeDialog.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/todayStates.dart';

import 'package:dailyquotes/view/errorScreen.dart';
import 'package:dailyquotes/view/defaultContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                      child: DefaultContainer(
                        quote: cubit.quote!,
                        height: height * 0.7,
                        stackButtons: [
                          Positioned(
                            right: 50,
                            bottom: -15,
                            child: InkWell(
                              onTap: () {
                                cubit.addToPopular(cubit.quote!);
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.gradientColors[2],
                                child:  Icon(
                                cubit.fav?  Icons.favorite: Icons.favorite_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -15,
                            child: InkWell(
                              onTap: () {},
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
