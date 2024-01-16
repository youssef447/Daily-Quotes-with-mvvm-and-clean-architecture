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
        elevation: MaterialStateProperty.all<double>(elevation ?? 0),
        shadowColor:
            MaterialStateProperty.all<Color>(shadowColor ?? Colors.white),
        foregroundColor:
            MaterialStateProperty.all<Color>(foregroundColor ?? Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(raduis ?? 0),
            side: BorderSide(
              color: sideColor ?? Colors.transparent,
            ),
          ),
        ),
        minimumSize: MaterialStateProperty.all(
           Size(width??double.infinity, height??55),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(backgroundColor ?? Colors.black),
      ),
      onPressed: onClicked,
      child: child,
    );
  }
}
