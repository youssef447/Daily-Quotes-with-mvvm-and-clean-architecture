import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errMsg;
  final Function() retry;
  const ErrorScreen({
    super.key,
    required this.errMsg,
    required this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error Getting Data $errMsg',
            style: Theme.of(context).textTheme.titleMedium!,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: retry,
            child: Text(
              'Retry',
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
        ],
      ),
    );
  }
}
