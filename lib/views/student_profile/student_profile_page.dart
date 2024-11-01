import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/view_model/utils/sa_informants.dart';
import 'package:student_assess/views/widgets/student_assess_button_widget.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 18.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: 32.w700,
                ),
                SizedBox(height: 18.h),
                ListTile(
                  tileColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  title: Text("USERNAME", style: 18.w400),
                  subtitle: Text("Your Username (Comming in next update)",
                      style: 22.w600),
                ),
                SizedBox(height: 66.h),
                StudentAssessButton(
                    pressedAction: () {
                      StudentAssessInformant.showPopupDialog(
                          context: context,
                          icon: const Icon(Icons.punch_clock_rounded),
                          message: "Feature coming in next update");
                    },
                    buttonText: "Upload CGPA Data",
                    buttonColor: AppColor.blue,
                    buttonTextColor: AppColor.white),
                SizedBox(height: 18.h),
                StudentAssessButton(
                    pressedAction: () {
                      StudentAssessInformant.showPopupDialog(
                          context: context,
                          icon: const Icon(Icons.punch_clock_rounded),
                          message: "Feature coming in next update");
                    },
                    buttonText: "Update Profile Information",
                    buttonColor: AppColor.black,
                    buttonTextColor: AppColor.white),
                SizedBox(height: 18.h),
                StudentAssessButton(
                    pressedAction: () {
                      StudentAssessInformant.showPopupDialog(
                          context: context,
                          icon: const Icon(Icons.punch_clock_rounded),
                          message: "Feature coming in next update");
                    },
                    buttonText: "Delete All Data",
                    buttonColor: Colors.red,
                    buttonTextColor: AppColor.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
