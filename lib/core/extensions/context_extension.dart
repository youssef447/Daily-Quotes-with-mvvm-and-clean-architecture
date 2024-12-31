import 'package:flutter/Material.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  navigateTo(Widget screen) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  navigate(Widget screen) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
