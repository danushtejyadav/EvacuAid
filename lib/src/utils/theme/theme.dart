import "package:evacuaid/src/utils/theme/widget_themes/elevated_button_theme.dart";
import "package:evacuaid/src/utils/theme/widget_themes/outlined_button_theme.dart";
import "package:evacuaid/src/utils/theme/widget_themes/text_field_theme.dart";
import "package:evacuaid/src/utils/theme/widget_themes/text_theme.dart";
import "package:flutter/material.dart";

class EvacTheme {

  EvacTheme._();

  // Light Theme Settings
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: EvacTextTheme.lightTextTheme,
    outlinedButtonTheme: EvacOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: EvacElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: EvacTextFormFieldTheme.lightInputDecorationTheme,
  );

  // Dark Theme Settings
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: EvacTextTheme.darkTextTheme,
    outlinedButtonTheme: EvacOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: EvacElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: EvacTextFormFieldTheme.darkInputDecorationTheme,
  );
}