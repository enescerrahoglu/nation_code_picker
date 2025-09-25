import 'package:flutter/material.dart';
import 'package:nation_code_picker/theme/color_schemes.g.dart';

ThemeData lightTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  useMaterial3: true,
  colorScheme: lightColorScheme,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFF2F2F6),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xFFF2F2F6)),
  sliderTheme: const SliderThemeData(
      trackHeight: 1,
      thumbShape: RoundSliderThumbShape(elevation: 0, pressedElevation: 0)),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF000000)),
    bodyMedium: TextStyle(color: Color(0xFF000000)),
    bodySmall: TextStyle(color: Color(0xFF000000)),
    titleLarge: TextStyle(color: Color(0xFF000000)),
    titleMedium: TextStyle(color: Color(0xFF000000)),
    titleSmall: TextStyle(color: Color(0xFF000000)),
  ),
  datePickerTheme: DatePickerThemeData(
    headerHelpStyle: const TextStyle(fontSize: 16),
    headerHeadlineStyle:
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headerForegroundColor: const Color(0xFFe74c5d),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF2F2F6),
    foregroundColor: Color(0xFF000000),
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFFFFFFFF),
    hintStyle: TextStyle(color: Color(0xFF999999)),
    labelStyle: TextStyle(color: Color(0xFF999999)),
  ),
);

ThemeData darkTheme = ThemeData(
  splashFactory: NoSplash.splashFactory,
  useMaterial3: true,
  colorScheme: darkColorScheme,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFF1C1C1E),
  bottomSheetTheme:
      const BottomSheetThemeData(backgroundColor: Color(0xFF1C1C1E)),
  sliderTheme: const SliderThemeData(
      trackHeight: 1,
      thumbShape: RoundSliderThumbShape(elevation: 0, pressedElevation: 0)),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFFFFFF)),
    bodyMedium: TextStyle(color: Color(0xFFFFFFFF)),
    bodySmall: TextStyle(color: Color(0xFFFFFFFF)),
    titleLarge: TextStyle(color: Color(0xFFFFFFFF)),
    titleMedium: TextStyle(color: Color(0xFFFFFFFF)),
    titleSmall: TextStyle(color: Color(0xFFFFFFFF)),
  ),
  datePickerTheme: DatePickerThemeData(
    headerHelpStyle: const TextStyle(fontSize: 16),
    headerHeadlineStyle:
        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headerForegroundColor: const Color(0xFFe74c5d),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1C1C1E),
    foregroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Color(0xFF2C2C2E),
    hintStyle: TextStyle(color: Color(0xFF565658)),
    labelStyle: TextStyle(color: Color(0xFF565658)),
  ),
);

extension type const ChooseThemeMode(String themeMode) {
  ThemeMode get getThemeMode => switch (themeMode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
}
