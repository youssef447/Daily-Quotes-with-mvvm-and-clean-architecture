import 'package:flutter/Material.dart';

extension ContextExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  navigate(String route, {Object? arguments}) {
    Navigator.of(this).pushNamed(
      route,
      arguments: arguments,
    );
  }
}
