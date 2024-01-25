import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        'hello world',
        style: Theme.of(context).textTheme.titleLarge,
      )),
    );
  }
}
