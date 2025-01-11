import 'package:flutter/material.dart';

abstract class PageTransitionHelper {
  static PageRouteBuilder<dynamic> buildPageRoute(
      Widget page, PageTransitionType transitionType,
      {Duration? duration}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration ?? const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case PageTransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case PageTransitionType.slideFromRight:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case PageTransitionType.slideFromLeft:
            return SlideTransition(
              position: animation.drive(
                Tween(begin: const Offset(-1, 0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          case PageTransitionType.diagonalWithScale:
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: animation.drive(
                  Tween(begin: const Offset(-1, -1), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut)),
                ),
                child: ScaleTransition(scale: animation, child: child),
              ),
            );
          case PageTransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          // No animation
        }
      },
    );
  }
}

enum PageTransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  scale,
  diagonalWithScale
}
