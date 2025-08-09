import 'package:flutter/material.dart';

class AppColor {
  // Primary brand colors
  static const Color primary = Color(0xFF13A9F4);
  static const Color primaryVariant = Color(0xFF0D7FB8);
  static const Color secondary = Color(0xFFFC7100);
  static const Color secondaryVariant = Color(0xFFE6640A);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral colors
  static const Color surface = Color(0xFFFAFAFA);
  static const Color background = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212121);
  static const Color onBackground = Color(0xFF424242);
  static const Color outline = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1F000000);

  // Existing colors for backward compatibility
  static Color orange = secondary;
  static Color blue = primary;
  static Color white = background;
  static Color black = onSurface;
  static Color grey = const Color(0xFF9E9E9E);
  static Color darkGrey = const Color(0xFF616161);

  // Score colors
  static const Color scoreExcellent = Color(0xFF4CAF50);
  static const Color scoreGood = Color(0xFF2196F3);
  static const Color scoreAverage = Color(0xFFFF9800);
  static const Color scorePoor = Color(0xFFF44336);

  static Map<Color, Color> get contrast {
    return {
      orange: blue,
      white: black,
      black: white,
      grey: darkGrey,
      primary: background,
      secondary: background,
    };
  }

  static Color contrastColor(Color color) {
    assert(
      contrast.containsKey(color),
      'You have not provided any dark theme',
    );
    return contrast[color]!;
  }

  // Get score color based on percentage
  static Color getScoreColor(double score) {
    if (score >= 80) return scoreExcellent;
    if (score >= 70) return scoreGood;
    if (score >= 40) return scoreAverage;
    return scorePoor;
  }
}
