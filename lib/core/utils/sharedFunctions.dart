import 'package:flutter/material.dart';

navigateTo(BuildContext ctx, Widget screen) {
  Navigator.of(ctx).pushReplacement(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

navigate(BuildContext ctx, Widget screen) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}
