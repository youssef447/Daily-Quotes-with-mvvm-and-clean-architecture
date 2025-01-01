import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;
  final FocusNode? focusNode;
  final bool? isPassword;
  final bool? expand;
  final String? helperText;
  final int minLines;
  final int maxLines;
  final TextInputType? type;
  final bool? readOnly;
  final bool? filled;
  final Widget? label;
  final double? radius;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? hintStyle;

  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final String? labelText;
  final bool? borderNone;
  final double padding;
  final String? Function(String?)? validate;
  final Function(String)? onchanged;
  final Function()? suffixPressed;
  final Function()? onTap;
  final String? hintText;
  final bool? enabled;
  const DefaultFormField(
      {super.key,
      required this.controller,
      required this.context,
      this.style,
      this.hintStyle,
      this.isPassword,
      this.focusNode,
      this.enabled,
      this.type,
      this.maxLines = 1,
      this.minLines = 1,
      this.readOnly,
      this.filled,
      this.label,
      this.expand,
      this.helperText,
      this.radius,
      this.padding = 20,
      this.fillColor,
      this.onTap,
      this.prefixWidget,
      this.suffixWidget,
      this.labelText,
      this.borderNone,
      this.validate,
      this.onchanged,
      this.suffixPressed,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validate,
      controller: controller,

      obscureText: isPassword ?? false,
      keyboardType: type,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onChanged: onchanged,

      minLines: expand != null ? null : minLines,
      maxLines: expand != null ? null : maxLines,
      expands: expand != null ? true : false,
      //style of search text
      style: style ??
          GoogleFonts.gabriela(
            textStyle: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.normal),
          ),
      //onFieldSubmitted: ((value) => print(contoller.text)),
      focusNode: focusNode,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            GoogleFonts.gabriela(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
        helperText: helperText,
        enabled: enabled ?? true,
        label: label,
        helperMaxLines: 1,
        floatingLabelAlignment: FloatingLabelAlignment.start,

        contentPadding: EdgeInsets.all(padding),

        labelStyle: GoogleFonts.gabriela(
          textStyle: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        // focusColor: background,
        labelText: labelText,
        helperStyle: helperText != null
            ? GoogleFonts.gabriela(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.normal),
              )
            : const TextStyle(),

        filled: filled ?? false,

        fillColor: fillColor, // const Color(0xff21203e),
        prefixIcon: prefixWidget,

        prefixIconColor: Theme.of(context).iconTheme.color,

        suffixIcon: suffixWidget,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            radius ?? 0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: borderNone != null ? BorderSide.none : const BorderSide(),
          borderRadius: BorderRadius.circular(
            radius ?? 0,
          ),
        ),
      ),
    );
  }
}
