import "package:evacuaid/src/constants/colors.dart";
import "package:flutter/material.dart";

class EvacTextFormFieldTheme {
  EvacTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: EvacSecondaryColor,
        floatingLabelStyle: TextStyle(color: EvacSecondaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: EvacSecondaryColor),
        ),
      );

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
        border: OutlineInputBorder(),
        prefixIconColor: EvacSecondaryColor,
        floatingLabelStyle: TextStyle(color: EvacSecondaryColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: EvacSecondaryColor),
        ),
      );
}