import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class StudentAssessButton extends StatelessWidget {
  StudentAssessButton({
    super.key,
    required this.pressedAction,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  void Function() pressedAction;
  String buttonText;
  Color buttonColor;
  Color buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 66.h,
      child: MaterialButton(
        onPressed: pressedAction,
        color: buttonColor,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
        textColor: buttonTextColor,
        child: Text(
          buttonText,
          style: 16.w700,
        ),
      ),
    );
  }
}
