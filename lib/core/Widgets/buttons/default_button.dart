import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function()? onClicked;
  final double? elevation;
  final Color? shadowColor;
  final Color? foregroundColor;
  final Color? backgroundColor;

  final Color? sideColor;
  final double? raduis;
  final Widget child;
  final double? width;
  final double? height;

  const DefaultButton(
      {super.key,
      this.onClicked,
      this.width,
      this.height,
      this.backgroundColor,
      this.elevation,
      this.foregroundColor,
      this.shadowColor,
      required this.child,
      this.sideColor,
      this.raduis});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll<double>(elevation ?? 0),
        shadowColor: WidgetStatePropertyAll<Color>(shadowColor ?? Colors.white),
        foregroundColor:
            WidgetStatePropertyAll<Color>(foregroundColor ?? Colors.white),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis ?? 0),
            side: BorderSide(
              color: sideColor ?? Colors.transparent,
            ),
          ),
        ),
        minimumSize: WidgetStatePropertyAll(
          Size(width ?? double.infinity, height ?? 55),
        ),
        backgroundColor:
            WidgetStatePropertyAll<Color>(backgroundColor ?? Colors.black),
      ),
      onPressed: onClicked,
      child: child,
    );
  }
}
