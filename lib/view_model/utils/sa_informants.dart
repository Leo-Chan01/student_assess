import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentAssessInformant {
  static void showPopupDialog(
      {required BuildContext context,
      required Widget icon,
      required String message}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)),
            insetAnimationDuration: const Duration(seconds: 1),
            insetAnimationCurve: Curves.easeInOut,
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    height: 24.sp,
                  ),
                  Text(
                    message,
                    style: Theme.of(context).textTheme.titleLarge,
                    textScaler: MediaQuery.maybeTextScalerOf(context),
                  )
                ],
              ),
            ),
          );
        });
  }
}
