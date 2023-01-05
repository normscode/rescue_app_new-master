import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/colors.dart';
import 'package:rescue_app/src/constants/sizes.dart';

/* Light and Dark Outlined Button Themes */
class ROutlinedButtonTheme {
  ROutlinedButtonTheme._(); // To Avoid Creating Instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: rSecondaryColor,
      side: BorderSide(color: rSecondaryColor),
      padding: EdgeInsets.symmetric(vertical: rButtonHeight),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: rWhiteColor,
      side: BorderSide(color: rWhiteColor),
      padding: EdgeInsets.symmetric(vertical: rButtonHeight),
    ),
  );
}
