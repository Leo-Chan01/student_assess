import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/config/color.dart';

// ignore: must_be_immutable
class StudentAssessTextField extends StatelessWidget {
  StudentAssessTextField(
      {super.key,
      required this.inputcontroller,
      required this.hintText,
      this.maxLinesNeeded,
      this.inputType});

  final TextEditingController inputcontroller;
  String hintText;
  int? maxLinesNeeded;
  TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hintText,
          fillColor: AppColor.grey.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.r))),
      keyboardType: inputType ?? TextInputType.multiline,
      minLines: 1,
      controller: inputcontroller,
      maxLines: (maxLinesNeeded != null) ? maxLinesNeeded : null,
      expands: false,
    );
  }
}
