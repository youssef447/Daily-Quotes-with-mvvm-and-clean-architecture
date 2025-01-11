import 'package:flutter/material.dart';

class ScaleAnimation extends StatefulWidget {
  final Widget child;

  final double? delay;
  final Duration? duration;
  const ScaleAnimation({
    super.key,
    required this.child,
    this.delay,
    this.duration,
  });

  @override
  ScaleAnimationState createState() => ScaleAnimationState();
}

class ScaleAnimationState extends State<ScaleAnimation>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation, fadeAnimation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 600,
          ),
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    fadeAnimation = Tween<double>(begin: -0.5, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    if (widget.delay != null) {
      Future.delayed(Duration(milliseconds: (500 + widget.delay!).round()))
          .then((value) {
        controller.forward();
      });
    } else {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
