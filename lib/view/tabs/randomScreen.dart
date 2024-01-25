import 'package:dailyquotes/Widgets/defaultButton.dart';
import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/core/utils/defaultAwesomeDialog.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/core/utils/sharedAssets.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomStates.dart';
import 'package:dailyquotes/view/defaultContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

class RandomScreen extends StatefulWidget {
  final bool longRectangle;

  const RandomScreen({super.key, required this.longRectangle});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomCubit, RandomStates>(
      listener: (context, state) {
        if (state is AddToPopularSuccessState) {
          AwesomeDialogUtil.sucess(
            context: context,
            body: 'Quote Added To Favorite',
            title: 'Done',
          );
        }
        if (state is GetRandomErrorState) {
          AwesomeDialogUtil.error(
              context: context,
              body: '${state.err}, please try again',
              title: 'Error getting random Quote');
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
        var cubit = RandomCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            state is GetRandomLoadingState
                ? const CircularProgressIndicator()
                : state is GetRandomSuccessState
                    ? DefaultContainer(
                        quote: cubit.quote!,
                        height: widget.longRectangle
                            ? height * 0.68
                            : height * 0.23,
                        stackButtons: [
                            Positioned(
                              right: 50,
                              bottom: -15,
                              child: InkWell(
                                overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent,
                                ),
                                onTap: () async {
                                  if (cubit.quote!.fav) {
                                    await cubit.removeFromPopular();
                                  } else {
                                    await cubit.addToPopular();
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.gradientColors[2],
                                  child: Icon(
                                    cubit.quote!.fav
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
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
                                  await cubit.shareQuote();
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.gradientColors[2],
                                  child: const FaIcon(
                                    FontAwesomeIcons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ])
                    : Lottie.asset(
                        AnimsAssets.singleQuote,
                        frameRate: const FrameRate(120),
                      ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 2),
                end: Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticOut,
                ),
              ),
              child: DefaultButton(
                onClicked: () {
                  cubit.getRandomQuote();
                },
                backgroundColor: AppColors.gradientColors[2],
                raduis: 25,
                width: width * 0.6,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Get Random Quote',
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.format_quote_sharp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
