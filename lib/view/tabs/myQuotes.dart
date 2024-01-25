import 'dart:ui';

import 'package:dailyquotes/core/utils/defaultDialog.dart';
import 'package:dailyquotes/core/utils/defaultModalBottomSheet.dart';
import 'package:dailyquotes/view-model/TabsCubit/myQuotesCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/myQuotesStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/FadeInDown.dart';
import '../../Widgets/defaultCarouselSlider.dart';
import '../../core/utils/appColors.dart';
import '../../core/utils/globales.dart';
import '../../core/utils/sharedAssets.dart';
import '../AddEditQuoteScreen.dart';
import '../defaultContainer.dart';

class MyQuotes extends StatefulWidget {
  final bool longRectangle;

  const MyQuotes({super.key, required this.longRectangle});

  @override
  State<MyQuotes> createState() => _MyQuotesState();
}

class _MyQuotesState extends State<MyQuotes>
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
    return BlocConsumer<MyQuotesCubit, MyQuotesStates>(
      listener: (context, state) {
        if (state is RemoveMyQuoteSuccessState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var cubit = MyQuotesCubit.get(context);
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: cubit.myQuotes.isNotEmpty
              ? FloatingActionButton(
                  shape: const CircleBorder(),
                  onPressed: () {
                    DefaultModalBottomSheet.Default(
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
            backgroundColor: AppColors.defaultColor,
            color: AppColors.gradientColors[1],
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            onRefresh: () async {
              return await cubit.getMyQuotes();
            },
            child: cubit.myQuotes.isEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent,
                              ),
                              onTap: () {
                                DefaultModalBottomSheet.Default(
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
                      itemCount: cubit.myQuotes.length,
                      viewPortFraction: widget.longRectangle ? 0.8 : 0.3,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return FadeInDown(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topRight,
                            children: [
                              DefaultContainer(
                                quote: cubit.myQuotes[itemIndex],
                                height: widget.longRectangle
                                    ? height * 0.68
                                    : height * 0.23,
                                stackButtons: [
                                  Positioned(
                                    bottom: -15,
                                    child: InkWell(
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.transparent,
                                      ),
                                      onTap: () async {
                                        await cubit.shareQuote(
                                            cubit.myQuotes[itemIndex]);
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
                                          MaterialStateProperty.all<Color>(
                                        Colors.transparent,
                                      ),
                                      onTap: () async {
                                       DefaultModalBottomSheet.Default(
                                            context: context,
                                            transitionAnimationController:
                                                controller,
                                            child: AddEditQuote(
                                              edit: true,
                                              quote: cubit.myQuotes[itemIndex],
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
                                      builder: (context) => FadeInDown(
                                        child: DefaultAlertDialog.Confirm(
                                            content:
                                                'Are You sure you want to delete this quote?',
                                            icon: Icons.question_mark_sharp,
                                            iconColor:
                                                AppColors.selectedItemColor,
                                            defaultTextStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            onNoClicked: () =>
                                                Navigator.of(context).pop(),
                                            onYesClicked: () {
                                              cubit.removeMyQuote(cubit
                                                  .myQuotes[itemIndex].id!);
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
    );
  }
}
