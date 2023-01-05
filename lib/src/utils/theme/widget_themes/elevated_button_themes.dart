import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/sizes.dart';

/* Light and Dark Outlined Button Themes */
class RElevatedButtonTheme {
  RElevatedButtonTheme._(); // To Avoid Creating Instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: rWhiteColor,
      backgroundColor: rSecondaryColor,
      side: const BorderSide(color: rSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: rButtonHeight),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: rSecondaryColor,
      backgroundColor: rWhiteColor,
      side: const BorderSide(color: rSecondaryColor),
      padding: const EdgeInsets.symmetric(vertical: rButtonHeight),
    ),
  );
}
