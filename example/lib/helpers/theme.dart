import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit_example/helpers/colors.dart';

class flutter_nfc_kit_exampleTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      primary: primaryColor,
      primaryContainer: primaryColor,
      secondary: primaryColor,
      secondaryContainer: Color(0x54000000),
      surface: primaryColor,
      background: Color(0xffF5F3F3),
      error: dangerColor,
      onPrimary: Colors.white,
      onSecondary: secondaryColor,
      onSurface: primaryColor,
      onBackground: primaryColor,
      onError: dangerColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xffF5FFFB),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xffF5F3F3),
      elevation: 0,
    ),
    fontFamily: 'Archivo',
  );
  static ThemeData darkTheme = ThemeData.dark();
}
