import 'package:dailyquotes/core/helpers/spacing_helper.dart';

import 'package:dailyquotes/core/widgets/error_page.dart';
import 'package:dailyquotes/presentation/popular_quotes_page/controller/popular_cubit.dart';
import 'package:dailyquotes/presentation/popular_quotes_page/controller/popular_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/core/widgets/sliders/default_carousel_slider.dart';
import 'package:dailyquotes/core/widgets/animations/fade_in_down_animation.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';

import 'package:dailyquotes/core/constants/assets.dart';
import 'package:dailyquotes/main.dart';

import 'package:dailyquotes/core/widgets/cards/quote_card.dart';
part '../widgets/no_popular_widget.dart';
part '../widgets/erro_popular_widget.dart';

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

          return RefreshIndicator(
            backgroundColor: AppColorsProvider.of(context).appColors.background,
            color: AppColorsProvider.of(context).appColors.primary,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              return await cubit.getPopularQuotes();
            },
            child: state is GetPopularLoadingState
                ? const DefaultLoadingIndicator()
                : cubit.popularQuotes.isEmpty
                    ? const NoPopularQuotesWidget()
                    : state is GetPopularErrorState
                        ? ErrorPopularWidget(
                            errorMsg: state.err,
                            cubit: cubit,
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
                                              const WidgetStatePropertyAll<
                                                  Color>(
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
                                                AppColorsProvider.of(context)
                                                    .appColors
                                                    .secondaryPrimary,
                                            child: Icon(
                                              Icons.favorite,
                                              color:
                                                  AppColorsProvider.of(context)
                                                      .appColors
                                                      .icon,
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
                                                AppColorsProvider.of(context)
                                                    .appColors
                                                    .secondaryPrimary,
                                            child: FaIcon(
                                              FontAwesomeIcons.share,
                                              color:
                                                  AppColorsProvider.of(context)
                                                      .appColors
                                                      .icon,
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
