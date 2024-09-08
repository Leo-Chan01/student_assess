import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class CgpaMainscreen extends StatelessWidget {
  const CgpaMainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 28.sp),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student Room",
                style: 32.w700,
              ),
              SizedBox(
                height: 28.h,
              ),
              Text("What do you want to do?", style: 16.w400),
              SizedBox(height: 65.h),
              SizedBox(
                height: 90.sp,
                width: double.infinity,
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {
                    context.go(AppRoutes.cgpaRegisterCoursesRoute);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: AppColor.black,
                  textColor: AppColor.white,
                  child: Text(
                    "Register my courses",
                    style: 18.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 90.sp,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    context.go(AppRoutes.cgpaCalculateCgpaRoute);
                  },
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: AppColor.blue,
                  textColor: AppColor.white,
                  child: Text(
                    "Calculate my CGPA",
                    style: 18.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 90.sp,
                width: double.infinity,
                child: MaterialButton(
                  elevation: 0,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  color: AppColor.grey.withOpacity(0.1),
                  textColor: AppColor.darkGrey,
                  child: Text(
                    "Get Course Materials",
                    style: 18.w600,
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
