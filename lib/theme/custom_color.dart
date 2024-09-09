import 'package:flutter/material.dart';

class CustomColor {
  static const int _primary = 0Xff0CD3F8;
  static const MaterialColor primary = MaterialColor(_primary, {
    50: Color(0xffE7FBFE),
    100: Color(0xffB4F1FD),
    200: Color(0xff8FEBFC),
    300: Color(0xff5CE2FA),
    400: Color(0xff3DDCF9),
    500: Color(
      _primary,
    ),
    600: Color(0xff0BC0E2),
    700: Color(0xff0996B0),
    800: Color(0xff077488),
    900: Color(0xff055968),
  });

  static const ColorSwatch colors = ColorSwatch(_primary, {
    PRIMARY: Color(_primary),
  });

  static const Color secondaryColor = Color(0xFFEEF2FE);
}

const String PRIMARY = "primary";
