import 'package:flutter/material.dart';

class BouncingSlideAnimation extends StatefulWidget {
  final Widget child;

  const BouncingSlideAnimation({
    super.key,
    required this.child,
  });

  @override
  State<BouncingSlideAnimation> createState() => _BouncingSlideAnimationState();
}

class _BouncingSlideAnimationState extends State<BouncingSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    fadeAnimation = Tween<double>(begin: -0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    slideAimation = Tween<Offset>(
      begin: Offset(0, 5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
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
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAimation,
        child: widget.child,
      ),
    );
  }
}
