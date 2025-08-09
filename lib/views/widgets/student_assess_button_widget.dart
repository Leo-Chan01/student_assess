import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class StudentAssessButton extends StatelessWidget {
  const StudentAssessButton({
    super.key,
    required this.pressedAction,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
  });

  final void Function()? pressedAction;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : pressedAction,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: buttonTextColor,
          elevation: 2,
          shadowColor: AppColor.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.sp),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        ),
        child: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(buttonTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.sp),
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    buttonText,
                    style: 16.w600.copyWith(color: buttonTextColor),
                  ),
                ],
              ),
      ),
    );
  }
}
