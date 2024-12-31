import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/Widgets/dialogs/default_awesome_dialog.dart';
import 'package:dailyquotes/core/utils/utils.dart';
import 'package:dailyquotes/core/constants/assets.dart';
import 'package:dailyquotes/features/random_quote_page/presentation/controller/random_cubit.dart';
import 'package:dailyquotes/features/random_quote_page/presentation/controller/random_states.dart';
import 'package:dailyquotes/core/Widgets/cards/quote_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/Widgets/buttons/default_button.dart';

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
    return BlocProvider(
      create: (context) => RandomCubit(),
      child: BlocConsumer<RandomCubit, RandomStates>(
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
                      ? QuoteCard(
                          quote: cubit.quote!,
                          height: widget.longRectangle
                              ? height * 0.68
                              : height * 0.23,
                          stackButtons: [
                              Positioned(
                                right: 50,
                                bottom: -15,
                                child: InkWell(
                                  overlayColor: WidgetStatePropertyAll<Color>(
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
                                    backgroundColor:
                                        AppColors.gradientColors[2],
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
                                  overlayColor: WidgetStatePropertyAll<Color>(
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
      ),
    );
  }
}
