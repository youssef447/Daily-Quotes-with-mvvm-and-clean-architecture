import 'dart:ui';

import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';

import 'package:dailyquotes/core/widgets/error_page.dart';
import 'package:dailyquotes/core/widgets/cards/quote_card.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/animations/fade_In_down_animation.dart';

import '../../../../core/theme/colors/app_colors.dart';

import '../../controller/today_quotes_cubit.dart';
import '../../controller/today_quotes_states.dart';

class TodayQuotePage extends StatelessWidget {
  const TodayQuotePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodayQuoteCubit, TodayQuoteStates>(
        listener: (context, state) {
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
      var cubit = context.read<TodayQuoteCubit>();

      if (state is GetTodayQuoteLoadingState) {
        return const DefaultLoadingIndicator();
      }
      if (state is GetTodayQuoteErrorState) {
        return ErrorPage(errMsg: state.err, retry: () async {});
      }

      return RefreshIndicator(
        backgroundColor: AppColors.background,
        color: AppColors.gradientColors[1],
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          return await cubit.getTodayQuote();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    Center(
                      child: FadeInDownAnimation(
                        child: QuoteCard(
                          quote: cubit.todayQuote,
                          stackButtons: [
                            Positioned(
                              right: 50.w,
                              bottom: -15.h,
                              child: InkWell(
                                overlayColor: WidgetStatePropertyAll<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () {
                                  cubit.todayQuote.fav == false
                                      ? cubit.addToPopular()
                                      : cubit.removeFromPopular();
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.secondaryPrimary,
                                  child: Icon(
                                    cubit.todayQuote.fav == false
                                        ? Icons.favorite_outline
                                        : Icons.favorite,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -15.h,
                              child: InkWell(
                                overlayColor: WidgetStatePropertyAll<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () async {
                                  await cubit.shareQuote();
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.secondaryPrimary,
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
                    if (state is AddToPopularLoadingState)
                      ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 3.0,
                            sigmaY: 3.0,
                          ),
                          child: const DefaultLoadingIndicator(),
                        ),
                      )
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
