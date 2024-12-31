import 'package:flutter/material.dart';

class FadeInDownAnimation extends StatefulWidget {
  final Widget child;
  // ignore: use_key_in_widget_constructors
  const FadeInDownAnimation({required this.child});

  @override
  _FadeInDownAnimationState createState() => _FadeInDownAnimationState();
}

class _FadeInDownAnimationState extends State<FadeInDownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    translateAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
    controller.forward();
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
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
