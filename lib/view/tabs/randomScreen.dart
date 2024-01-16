import 'package:dailyquotes/Widgets/defaultButton.dart';
import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:dailyquotes/core/utils/globales.dart';
import 'package:dailyquotes/core/utils/sharedAssets.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomCubit.dart';
import 'package:dailyquotes/view-model/TabsCubit/randomStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class RandomScreen extends StatelessWidget {
  const RandomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RandomCubit, RandomStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RandomCubit.get(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AnimsAssets.singleQuote,
                frameRate: const FrameRate(120),
              ),
              state is GetRandomLoadingState
                  ? const CircularProgressIndicator()
                  : DefaultButton(
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
                          Text('Get Random Quote',
                              style: Theme.of(context).textTheme.titleMedium!),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.format_quote_sharp,
                          ),
                        ],
                      ),
                    ),
            ],
          );
        });
  }
}
