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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/appColors.dart';

class TodayScreen extends StatelessWidget {
  final bool longRectangle;
  const TodayScreen({super.key, required this.longRectangle});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodayCubit, TodayStates>(listener: (context, state) {
      /* if (state is AddToPopularSuccessState) {
        AwesomeDialogUtil.sucess(
            context: context, body: 'Quote Added To Favorite', title: 'Done');
      } */
      if (state is AddToPopularErrorState) {
        AwesomeDialogUtil.error(
          context: context,
          body: 'Error Adding Quote To Favorite',
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
    }, builder: (context, state) {
      var cubit = TodayCubit.get(context);

      return RefreshIndicator(
        backgroundColor: AppColors.defaultColor,
        color: AppColors.gradientColors[1],
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          return await cubit.getTodayQuote();
        },
        child: state is GetTodayQuoteLoadingState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state is GetTodayQuoteErrorState
                ? CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      ErrorScreen(
                          errMsg: state.err,
                          retry: () async {
                            await cubit.getTodayQuote();
                          }),
                    ],
                  )
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child: Stack(
                            children: [
                              Center(
                                child: FadeInDown(
                                  child: DefaultContainer(
                                    quote: todayQuote,
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
                                          onTap: () {
                                            todayQuote.fav == false
                                                ? cubit.addToPopular(todayQuote)
                                                : cubit.removeFromPopular(
                                                    todayQuote);
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                AppColors.gradientColors[2],
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
                                          overlayColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.transparent,
                                          ),
                                          onTap: () async {
                                           await cubit.shareQuote();
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
                          ),
                        ),
                      );
                    },
                  ),
      );
    });
  }
}
