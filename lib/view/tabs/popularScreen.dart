import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyquotes/core/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/globales.dart';
import '../../core/utils/sharedAssets.dart';
import '../../view-model/TabsCubit/popularCubit.dart';
import '../../view-model/TabsCubit/popularStates.dart';
import '../defaultContainer.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularCubit, PopularStates>(
      listener: (BuildContext context, PopularStates state) {},
      builder: (context, state) {
        var cubit = PopularCubit.get(context);
        return cubit.popularQuotes.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    AnimsAssets.fav,
                    frameRate: const FrameRate(120),
                  ),
                  Text(
                    'No Quotes Added Yet',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppColors.selectedItemColor,
                        ),
                  ),
                ],
              )
            : CarouselSlider.builder(
                itemCount: cubit.popularQuotes.length,
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  // viewportFraction: 0.3, //square
                  viewportFraction: 0.7, //recatngle

                  initialPage: 0,
                  reverse: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.vertical,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return DefaultContainer(
                    quote: cubit.popularQuotes[itemIndex],
                    height: height * 0.7,
                   stackButtons: [       
        Positioned(
          bottom: -15,
          child: InkWell(
            onTap: (){
              
            },
            child: CircleAvatar(
              backgroundColor: AppColors.gradientColors[2],
              child: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
          ),
        ),],
                  );
                },
              );
      },
    );
  }
}
