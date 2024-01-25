import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class DefaultCarouselSlider extends StatelessWidget {
  final int itemCount;
  final double viewPortFraction;
  final Widget Function(BuildContext, int, int)? itemBuilder;
  const DefaultCarouselSlider(
      {super.key,
      required this.itemCount,
      required this.viewPortFraction,
      this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        scrollPhysics: const AlwaysScrollableScrollPhysics(),
        viewportFraction: viewPortFraction,
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
      itemBuilder: itemBuilder,
    );
  }
}
