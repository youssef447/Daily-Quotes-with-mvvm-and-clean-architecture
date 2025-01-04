import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;

  ///reverse the animation to be Down To Up
  final bool? leftToRight;
  final double delay;
  const SlideAnimation({
    super.key,
    required this.child,
    this.leftToRight,
    this.delay = 0.0,
  });

  @override
  SlideAnimationState createState() => SlideAnimationState();
}

class SlideAnimationState extends State<SlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
    );
    translateAnimation = Tween<Offset>(
      begin: widget.leftToRight ?? false
          ? const Offset(-1, 0)
          : const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    Future.delayed(Duration(milliseconds: (500 + widget.delay).round()))
        .then((value) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: translateAnimation,
        child: widget.child,
      ),
    );
  }
}
