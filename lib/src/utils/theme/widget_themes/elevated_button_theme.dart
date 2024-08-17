import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:flutter/material.dart";

class EvacElevatedButtonTheme {
  EvacElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      backgroundColor: EvacSecondaryColor,
      foregroundColor: EvacWhiteColor,
      padding: EdgeInsets.symmetric(vertical: EvacButtonHeight),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      backgroundColor: EvacSecondaryColor,
      foregroundColor: EvacWhiteColor,
      padding: EdgeInsets.symmetric(vertical: EvacButtonHeight),
    ),
  );
}