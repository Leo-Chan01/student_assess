import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/theme_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool showLabel;
  final double? iconSize;

  const ThemeToggleButton({
    super.key,
    this.showLabel = false,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          onPressed: () {
            themeProvider.toggleTheme();
          },
          icon: Icon(
            themeProvider.themeIcon,
            size: iconSize ?? 24.sp,
            color: AppColor.primary,
          ),
          tooltip: 'Switch to ${_getNextThemeName(themeProvider.themeMode)}',
        );
      },
    );
  }

  String _getNextThemeName(ThemeMode currentMode) {
    switch (currentMode) {
      case ThemeMode.light:
        return 'Dark Mode';
      case ThemeMode.dark:
        return 'Light Mode';
      case ThemeMode.system:
        return 'Light Mode';
    }
  }
}

class ThemeToggleCard extends StatelessWidget {
  const ThemeToggleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ListTile(
            leading: Icon(
              themeProvider.themeIcon,
              color: AppColor.primary,
            ),
            title: Text(
              'Theme',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              themeProvider.themeName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
            trailing: PopupMenuButton<ThemeMode>(
              icon: Icon(
                Icons.arrow_drop_down,
                color: AppColor.primary,
              ),
              onSelected: (ThemeMode mode) {
                themeProvider.setThemeMode(mode);
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: ThemeMode.system,
                  child: Row(
                    children: [
                      Icon(
                        Icons.brightness_auto,
                        color: themeProvider.isSystemMode
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                      SizedBox(width: 8.w),
                      const Text('System'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: ThemeMode.light,
                  child: Row(
                    children: [
                      Icon(
                        Icons.light_mode,
                        color: themeProvider.isLightMode
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                      SizedBox(width: 8.w),
                      const Text('Light'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: ThemeMode.dark,
                  child: Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: themeProvider.isDarkMode
                            ? AppColor.primary
                            : Colors.grey,
                      ),
                      SizedBox(width: 8.w),
                      const Text('Dark'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
