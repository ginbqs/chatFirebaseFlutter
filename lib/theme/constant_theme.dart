import 'package:chat/theme/constant_color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorSchemeSeed: const Color.fromRGBO(86, 80, 14, 171),
);

// class ConstantTheme {
//   static const ColorScheme lightColorScheme = ColorScheme(
//     primary: ConstantColor.primary,
//     onPrimary: ConstantColor.primary,
//     secondary: Color(0xFFEFF3F3),
//     onSecondary: Color(0xFF322942),
//     error: Colors.redAccent,
//     onError: Colors.white,
//     surface: Color(0xFFFAFBFB),
//     onSurface: Color(0xFF241E30),
//     brightness: Brightness.light,
//   );
//   static const ColorScheme darkColorScheme = ColorScheme(
//     primary: Color(0xFFFF8383),
//     secondary: Color(0xFF4D1F7C),
//     surface: Color(0xFF1F1929),
//     error: Colors.redAccent,
//     onError: Colors.white,
//     onPrimary: Colors.white,
//     onSecondary: Colors.white,
//     onSurface: Colors.white,
//     brightness: Brightness.dark,
//   );
// }
