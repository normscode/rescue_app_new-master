import 'package:flutter/material.dart';
import 'package:rescue_app/src/utils/theme/widget_themes/elevated_button_themes.dart';
import 'package:rescue_app/src/utils/theme/widget_themes/icon_button_themes.dart';
import 'package:rescue_app/src/utils/theme/widget_themes/outlined_button_themes.dart';
import 'package:rescue_app/src/utils/theme/widget_themes/text_formfield_theme.dart';
import 'package:rescue_app/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: RElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
    iconTheme: RIconButtonTheme.lightIconButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: ROutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: RElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
    iconTheme: RIconButtonTheme.darkIconButtonTheme,
  );
}
