import 'dart:ui';

import 'package:dailyquotes/core/helpers/spacing_helper.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/core/widgets/sheets/default_botom_sheet.dart';
import 'package:dailyquotes/main.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_cubit.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/sliders/default_carousel_slider.dart';
import '../../../../core/widgets/animations/fade_In_down_animation.dart';

import 'package:dailyquotes/core/constants/assets.dart';
import '../../../add_edit_quote/ui/pages/add_edit_quote_page.dart';
import '../../../../core/widgets/cards/quote_card.dart';
part '../widgets/no_quotes.dart';
part '../widgets/delete_quote_button.dart';

class MyQuotesPage extends StatelessWidget {
  const MyQuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyQuotesCubit()..getMyQuotes(),
      child: BlocConsumer<MyQuotesCubit, MyQuotesPageStates>(
        listener: (context, state) {
          if (state is RemoveMyQuoteSuccessState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          var cubit = context.read<MyQuotesCubit>();

          return Scaffold(
            backgroundColor: AppColorsProvider.of(context).appColors.background,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: cubit.myQuotes.isNotEmpty
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      DefaultBottomSheet.Default(
                          context: context,
                          child: AddEditQuoteSheet(
                              myQuotesCubit: context.read<MyQuotesCubit>()));
                    },
                    backgroundColor:
                        AppColorsProvider.of(context).appColors.primary,
                    child: Icon(
                      Icons.format_quote_outlined,
                      color:
                          AppColorsProvider.of(context).appColors.floatingIcon,
                    ),
                  )
                : null,
            body: RefreshIndicator(
              backgroundColor:
                  AppColorsProvider.of(context).appColors.background,
              color: AppColorsProvider.of(context).appColors.primary,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                return await cubit.getMyQuotes();
              },
              child: state is GetMyQuotesPageLoadingState
                  ? const DefaultLoadingIndicator()
                  : cubit.myQuotes.isEmpty
                      ? const NoQuotes()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            DefaultCarouselSlider(
                              itemCount: cubit.myQuotes.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return FadeInDownAnimation(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.topRight,
                                    children: [
                                      QuoteCard(
                                        quote: cubit.myQuotes[itemIndex],
                                        stackButtons: [
                                          Positioned(
                                            bottom: -15.h,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await cubit.shareQuote(
                                                    cubit.myQuotes[itemIndex]);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColorsProvider.of(
                                                            context)
                                                        .appColors
                                                        .secondaryPrimary,
                                                child: FaIcon(
                                                  FontAwesomeIcons.share,
                                                  color: AppColorsProvider.of(
                                                          context)
                                                      .appColors
                                                      .icon,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -15.h,
                                            right: 50.w,
                                            child: GestureDetector(
                                              onTap: () async {
                                                DefaultBottomSheet.Default(
                                                    context: context,
                                                    child: AddEditQuoteSheet(
                                                        quote: cubit.myQuotes[
                                                            itemIndex],
                                                        myQuotesCubit:
                                                            context.read<
                                                                MyQuotesCubit>()));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColorsProvider.of(
                                                            context)
                                                        .appColors
                                                        .secondaryPrimary,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColorsProvider.of(
                                                          context)
                                                      .appColors
                                                      .icon,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      DeleteQuoteButton(
                                        cubit: cubit,
                                        itemIndex: itemIndex,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            if (state is RemoveMyQuoteLoadingState)
                              ClipRRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 3.0,
                                    sigmaY: 3.0,
                                  ),
                                  child: const DefaultLoadingIndicator(),
                                ),
                              ),
                          ],
                        ),
            ),
          );
        },
      ),
    );
  }
}
