
import 'package:flutter/material.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/theme.dart';


extension ColorExtension on Color {
  Color of(
    BuildContext context, {
    Color? dark,
  }) {
    var contrast = AppColor.contrastColor(this);
    if (AppTheme.isDarkMode(context)) {
      return dark ?? contrast;
    }
    return this;
  }
}
