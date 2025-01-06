abstract class CustomColorThemeStates {}

class CustomColorThemeStatesInitial extends CustomColorThemeStates {}

class ConfigThemeStateSuccess extends CustomColorThemeStates {}

class ConfigThemeStateError extends CustomColorThemeStates {
  final String error;
  ConfigThemeStateError(this.error);
}
