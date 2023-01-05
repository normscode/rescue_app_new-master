import 'package:flutter/material.dart';
import 'package:rescue_app/src/constants/colors.dart';
//Use this inside main Theme to call Light or dark Modes

class TTextFormFieldTheme {
  TTextFormFieldTheme._();
  static InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: rSecondaryColor,
    floatingLabelStyle: const TextStyle(color: rSecondaryColor),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: rSecondaryColor),
    ),
  );
  static InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    prefixIconColor: rPrimaryColor,
    floatingLabelStyle: const TextStyle(color: rPrimaryColor),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: rPrimaryColor),
    ),
  );
}
