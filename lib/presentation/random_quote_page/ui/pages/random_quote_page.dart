import 'package:dailyquotes/core/widgets/loading/default_loading_indicator.dart';
import 'package:dailyquotes/core/theme/app_colors.dart';
import 'package:dailyquotes/core/widgets/dialogs/default_awesome_dialog.dart';

import 'package:dailyquotes/core/constants/assets.dart';

import 'package:dailyquotes/core/widgets/cards/quote_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/widgets/buttons/default_button.dart';
import '../../controller/random_cubit.dart';
import '../../controller/random_states.dart';

class RandomQuotePage extends StatefulWidget {
  const RandomQuotePage({super.key});

  @override
  State<RandomQuotePage> createState() => _RandomQuotePageState();
}

class _RandomQuotePageState extends State<RandomQuotePage>
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
                  ? const DefaultLoadingIndicator()
                  : state is GetRandomSuccessState
                      ? QuoteCard(quote: cubit.quote!, stackButtons: [
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
                                backgroundColor: AppColors.secondaryPrimary,
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
                                backgroundColor: AppColors.secondaryPrimary,
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
                  backgroundColor: AppColors.secondaryPrimary,
                  raduis: 25,
                  width: 400.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Get Random Quote',
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                      SizedBox(
                        width: 10.w,
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
