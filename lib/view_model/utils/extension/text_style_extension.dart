import 'package:flutter/material.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/theme.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get underline {
    return copyWith(decoration: TextDecoration.underline);
  }

  TextStyle get shadow {
    return copyWith(
      shadows: [
        const BoxShadow(
          offset: Offset(1, 1),
          blurRadius: 10,
          color: Colors.black,
        )
      ],
    );
  }

  TextStyle of(
    BuildContext context, {
    required Color light,
    Color? dark,
  }) {
    if (AppTheme.isDarkMode(context)) {
      var contrast = AppColor.contrastColor(light);
      return copyWith(
        color: dark ?? contrast,
      );
    }
    return copyWith(color: light);
  }
}
