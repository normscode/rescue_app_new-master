import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/colors.dart';

/* Light and Dark Outlined Button Themes */
class RIconButtonTheme {
  RIconButtonTheme._(); // To Avoid Creating Instances

  /* -- Light Theme -- */
  static final lightIconButtonTheme = IconThemeData(color: rDarkColor);

  /* -- Dark Theme -- */
  static final darkIconButtonTheme = IconThemeData(color: rWhiteColor);
}
