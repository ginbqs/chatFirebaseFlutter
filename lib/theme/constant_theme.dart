import 'package:chat/theme/custom_color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  useMaterial3: true,
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  useMaterial3: true,
);
const ColorScheme lightColorScheme = ColorScheme.light(
  primary: CustomColor.primary,
  onPrimary: CustomColor.primary,
);

const ColorScheme darkColorScheme = ColorScheme.dark(
  primary: CustomColor.primary,
  onPrimary: CustomColor.primary,
);
