import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/config/color.dart';

class StudentAssessTextField extends StatelessWidget {
  const StudentAssessTextField({
    super.key,
    required this.inputcontroller,
    required this.hintText,
    this.maxLinesNeeded,
    this.inputType,
    this.validator,
    this.enabled = true,
  });

  final TextEditingController inputcontroller;
  final String hintText;
  final int? maxLinesNeeded;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputcontroller,
      keyboardType: inputType ?? TextInputType.multiline,
      minLines: 1,
      maxLines: maxLinesNeeded,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.grey,
          fontSize: 14.sp,
        ),
        fillColor:
            enabled ? AppColor.background : AppColor.grey.withOpacity(0.1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primary, width: 2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error, width: 1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error, width: 2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
    );
  }
}
