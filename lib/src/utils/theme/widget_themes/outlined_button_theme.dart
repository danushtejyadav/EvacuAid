import "package:evacuaid/src/constants/colors.dart";
import "package:evacuaid/src/constants/sizes.dart";
import "package:flutter/material.dart";

class EvacOutlinedButtonTheme {
  EvacOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      backgroundColor: EvacAccentColor,
      foregroundColor: EvacWhiteColor,
      padding: EdgeInsets.symmetric(vertical: EvacButtonHeight),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      backgroundColor: EvacAccentColor,
      foregroundColor: EvacWhiteColor,
      padding: EdgeInsets.symmetric(vertical: EvacButtonHeight),
    ),
  );
}