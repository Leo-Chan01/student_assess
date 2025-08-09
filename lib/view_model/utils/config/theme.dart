import 'package:flutter/material.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class AppTheme {
  static final AppTheme instance = AppTheme._init();
  AppTheme._init();

  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      surface: Color(0xFF1E1E1E),
      error: AppColor.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      centerTitle: false,
      elevation: 0,
      titleTextStyle: 18.w600.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  );

  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColor.primary,
      secondary: AppColor.secondary,
      surface: AppColor.surface,
      error: AppColor.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColor.onSurface,
      onError: Colors.white,
      outline: AppColor.outline,
    ),
    scaffoldBackgroundColor: AppColor.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.background,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: 18.w600.copyWith(color: AppColor.onSurface),
      iconTheme: const IconThemeData(color: AppColor.onSurface),
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: const CardThemeData(
      color: AppColor.background,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      shadowColor: AppColor.shadow,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColor.primary, width: 2),
      ),
    ),
  );

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static bool _assetExists(String assetPath) {
    try {
      Image.asset(assetPath);
      return true;
    } catch (e) {
      // If an error occurs, the asset does not exist
      return false;
    }
  }

  static String getAsset(BuildContext context, String assetName) {
    String name = assetName.split('/').last;

    String dark = 'assets/svg/dark/$name';
    String light = 'assets/svg/light/$name';
    assert(_assetExists(dark), '$assetName does not exist');
    assert(_assetExists(light), '$assetName does not exist');
    if (isDarkMode(context)) {
      return dark;
    } else {
      return light;
    }
  }
}
