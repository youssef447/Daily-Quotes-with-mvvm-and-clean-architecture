import 'dart:ui';

import 'package:dailyquotes/core/Widgets/dialogs/default_alert_dialog.dart';
import 'package:dailyquotes/core/Widgets/sheets/default_botom_sheet.dart';
import 'package:dailyquotes/features/my_quotes_page/presentation/controller/my_quotes_cubit.dart';
import 'package:dailyquotes/features/my_quotes_page/presentation/controller/my_quotes_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/Widgets/sliders/default_carousel_slider.dart';
import '../../../../../core/animations/fade_In_down_animation.dart';
import '../../../../../core/enums/card_shape.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/globales.dart';
import 'package:dailyquotes/core/constants/assets.dart';
import '../../../../add_edit_quote/presentation/ui/pages/add_edit_quote_page.dart';
import '../../../../../core/Widgets/cards/quote_card.dart';
import '../../../../home_page/presentation/controller/home_cubit.dart';

class MyQuotesPage extends StatefulWidget {
  const MyQuotesPage({super.key});

  @override
  State<MyQuotesPage> createState() => _MyQuotesPageState();
}

class _MyQuotesPageState extends State<MyQuotesPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          var cubit = MyQuotesPageCubit.get(context);
          final isRectangle =
              context.read<HomeCubit>().cardShape == CardShape.rectangle;

          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: cubit.MyQuotesPage.isNotEmpty
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      DefaultBottomSheet.Default(
                          context: context,
                          transitionAnimationController: controller,
                          child: AddEditQuote());
                    },
                    child: const Icon(
                      Icons.format_quote_outlined,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.selectedItemColor,
                  )
                : null,
            body: RefreshIndicator(
              backgroundColor: AppColors.background,
              color: AppColors.gradientColors[1],
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                return await cubit.getMyQuotesPage();
              },
              child: cubit.MyQuotesPage.isEmpty
                  ? CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                overlayColor: WidgetStatePropertyAll<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () {
                                  DefaultBottomSheet.Default(
                                      context: context,
                                      transitionAnimationController: controller,
                                      child: AddEditQuote());
                                },
                                child: Lottie.asset(
                                  AnimsAssets.add,
                                  frameRate: const FrameRate(120),
                                ),
                              ),
                              Text(
                                'Tap To Add Your First Quote',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: AppColors.selectedItemColor,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox(
                      height: double.infinity,
                      child: DefaultCarouselSlider(
                        itemCount: cubit.MyQuotesPage.length,
                        viewPortFraction: isRectangle ? 0.8 : 0.3,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return FadeInDownAnimation(
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.topRight,
                              children: [
                                QuoteCard(
                                  quote: cubit.MyQuotesPage[itemIndex],
                                  height: isRectangle
                                      ? height * 0.68
                                      : height * 0.23,
                                  stackButtons: [
                                    Positioned(
                                      bottom: -15,
                                      child: InkWell(
                                        overlayColor:
                                            WidgetStatePropertyAll<Color>(
                                          Colors.transparent,
                                        ),
                                        onTap: () async {
                                          await cubit.shareQuote(
                                              cubit.MyQuotesPage[itemIndex]);
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
                                    Positioned(
                                      bottom: -15,
                                      right: 50,
                                      child: InkWell(
                                        overlayColor:
                                            WidgetStatePropertyAll<Color>(
                                          Colors.transparent,
                                        ),
                                        onTap: () async {
                                          DefaultBottomSheet.Default(
                                              context: context,
                                              transitionAnimationController:
                                                  controller,
                                              child: AddEditQuote(
                                                edit: true,
                                                quote: cubit
                                                    .MyQuotesPage[itemIndex],
                                              ));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              AppColors.gradientColors[2],
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: -28,
                                  right: -15,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            FadeInDownAnimation(
                                          child: DefaultAlertDialog.Confirm(
                                              content:
                                                  'Are You sure you want to delete this quote?',
                                              icon: Icons.question_mark_sharp,
                                              iconColor:
                                                  AppColors.selectedItemColor,
                                              defaultTextStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                              onNoClicked: () =>
                                                  Navigator.of(context).pop(),
                                              onYesClicked: () {
                                                cubit.removeMyQuote(cubit
                                                    .MyQuotesPage[itemIndex]
                                                    .id!);
                                              }),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.cancel_rounded,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                state is RemoveMyQuoteLoadingState
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
                          );
                        },
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
