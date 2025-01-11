import 'package:flutter/material.dart';

abstract class ContrastColorHelper {
  /// Returns a contrasting color based on the luminance of the primary and secondary primary colors.

  /// If both colors are light (luminance > 0.5), black is returned.
  /// If both colors are dark (luminance <= 0.5), white is returned.
  /// If one color is light and the other is dark, a contrasting color is returned (currently white, but can be changed).

  static Color cardContrastColor(Color primary, Color secondaryPrimary) {
    final double primaryLuminance = primary.computeLuminance();
    final double secondaryPrimaryLuminance =
        secondaryPrimary.computeLuminance();

    // Check if both colors are light or dark
    if (primaryLuminance >= 0.5 && secondaryPrimaryLuminance >= 0.5) {
      return Colors.black; // Return black for light colors
    } else if (primaryLuminance <= 0.4 && secondaryPrimaryLuminance <= 0.4) {
      return Colors.white; // Return white for dark colors
    } else {
      // If one color is light and the other is dark, return a contrasting color
      return Colors.white; // Change this to the desired contrasting color
    }
  }

  static Color contrastColor(Color secondaryColor) {
    final double secondaryColorLuminance = secondaryColor.computeLuminance();

    if (secondaryColorLuminance >= 0.5) {
      return Colors.black;
    } else if (secondaryColorLuminance <= 0.5) {
      return Colors.white;
    } else {
      return Colors.white; // Change this to the desired contrasting color
    }
  }

  static Color contrastBGColor(Color background) {
    final double luminance = background.computeLuminance();

    // Check if both colors are light or dark
    if (luminance > 0.5) {
      return Colors.black; // Return black for light colors
    } else {
      // If one color is is dark, return a contrasting color
      return Colors.white;
    }
  }
}
