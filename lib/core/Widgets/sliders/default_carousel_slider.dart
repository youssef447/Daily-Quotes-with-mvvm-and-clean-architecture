import 'package:carousel_slider/carousel_slider.dart';
import 'package:dailyquotes/core/extensions/context_extension.dart';
import 'package:dailyquotes/presentation/home_page/controller/home_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/home_page/controller/home_cubit.dart';
import '../../enums/card_shape.dart';

class DefaultCarouselSlider extends StatelessWidget {
  final int itemCount;

  final Widget Function(BuildContext, int, int)? itemBuilder;
  const DefaultCarouselSlider(
      {super.key, required this.itemCount, this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (previous, current) => current is ChangeShapeState,
        builder: (context, state) {
          final isRectangle =
              context.read<HomeCubit>().cardShape == CardShape.rectangle;
          return TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 350),
            curve: Curves.decelerate,
            tween: Tween<double>(
              begin: isRectangle ? 0.45 : 0.9,
              end: isRectangle ? 0.9 : 0.45,
            ),
            builder: (context, heightFactor, child) {
              return SizedBox(
                height: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: itemCount,
                  options: CarouselOptions(
                    height: isRectangle
                        ? context.height * 0.6
                        : context.height * 0.3,
                    viewportFraction: heightFactor,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection:
                        isRectangle ? Axis.horizontal : Axis.vertical,
                  ),
                  itemBuilder: itemBuilder,
                ),
              );
            },
          );
        });
  }
}
