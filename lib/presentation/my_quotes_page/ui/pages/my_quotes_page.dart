import 'dart:ui';

import 'package:dailyquotes/core/helpers/spacing_helper.dart';
import 'package:dailyquotes/core/theme/text/app_text_styles.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/core/widgets/sheets/default_botom_sheet.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_cubit.dart';
import 'package:dailyquotes/presentation/my_quotes_page/controller/my_quotes_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/sliders/default_carousel_slider.dart';
import '../../../../core/widgets/animations/fade_In_down_animation.dart';

import 'package:dailyquotes/core/theme/colors/app_colors.dart';

import 'package:dailyquotes/core/constants/assets.dart';
import '../../../add_edit_quote/ui/pages/add_edit_quote_page.dart';
import '../../../../core/widgets/cards/quote_card.dart';
part '../widgets/no_quotes.dart';
part '../widgets/delete_quote_button.dart';

class MyQuotesPage extends StatelessWidget {
  const MyQuotesPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyQuotesPageCubit()..getMyQuotesPage(),
      child: BlocConsumer<MyQuotesPageCubit, MyQuotesPageStates>(
        listener: (context, state) {
          if (state is RemoveMyQuotesPageuccessState) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          var cubit = context.read<MyQuotesPageCubit>();

          return Scaffold(
            backgroundColor: AppColors.background,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: cubit.MyQuotesPage.isNotEmpty
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      DefaultBottomSheet.Default(
                          context: context, child: AddEditQuoteSheet());
                    },
                    child: Icon(
                      Icons.format_quote_outlined,
                      color: AppColors.icon,
                    ),
                    backgroundColor: AppColors.primary,
                  )
                : null,
            body: RefreshIndicator(
              backgroundColor: AppColors.background,
              color: AppColors.primary,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                return await cubit.getMyQuotesPage();
              },
              child: state is GetMyQuotesPageLoadingState
                  ? const DefaultLoadingIndicator()
                  : cubit.MyQuotesPage.isEmpty
                      ? NoQuotes()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            DefaultCarouselSlider(
                              itemCount: cubit.MyQuotesPage.length,
                              itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) {
                                return FadeInDownAnimation(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.topRight,
                                    children: [
                                      QuoteCard(
                                        quote: cubit.MyQuotesPage[itemIndex],
                                        stackButtons: [
                                          Positioned(
                                            bottom: -15.h,
                                            child: GestureDetector(
                                              onTap: () async {
                                                await cubit.shareQuote(cubit
                                                    .MyQuotesPage[itemIndex]);
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.secondaryPrimary,
                                                child: FaIcon(
                                                  FontAwesomeIcons.share,
                                                  color: AppColors.icon,
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
                                                      quote: cubit.MyQuotesPage[
                                                          itemIndex],
                                                    ));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    AppColors.secondaryPrimary,
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppColors.icon,
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
                                  child: DefaultLoadingIndicator(),
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
