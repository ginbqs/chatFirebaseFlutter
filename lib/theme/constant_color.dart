import 'package:flutter/material.dart';

class ConstantColor {
  static const Color black = Color(0xFF000000);
  static const Color primary = Color(0X0CD3F8);

  static const int _primary = 0X0CD3F8;
  static const MaterialColor primaryData = MaterialColor(_primary, {
    50: Color(0xE7FBFE),
    100: Color(0xB4F1FD),
    200: Color(0x8FEBFC),
    300: Color(0x5CE2FA),
    400: Color(0x3DDCF9),
    500: Color(
      _primary,
    ),
    600: Color(0x0BC0E2),
    700: Color(0x0996B0),
    800: Color(0x077488),
    900: Color(0x055968),
  });

  static const List<MaterialColor> primaries = <MaterialColor>[primaryData];
}
