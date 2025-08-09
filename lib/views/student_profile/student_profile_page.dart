import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:student_assess/view_model/providers/auth_provider.dart';
import 'package:student_assess/view_model/providers/theme_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/views/widgets/student_assess_button_widget.dart';
import 'package:student_assess/views/widgets/theme_toggle_widget.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ThemeProvider>(
      builder: (context, authProvider, themeProvider, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 32.sp, horizontal: 18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profile",
                      style: 32.w700,
                    ),
                    SizedBox(height: 18.h),

                    // User Information Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundColor: AppColor.primary,
                                child: Icon(
                                  Icons.person,
                                  size: 30.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      authProvider.user?.displayName ??
                                          'Student',
                                      style: 20.w600,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      authProvider.user?.email ?? 'No email',
                                      style: 14.w400.copyWith(
                                            color: Colors.grey[600],
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32.h),

                    StudentAssessButton(
                        pressedAction: () {},
                        buttonText: "Upload CGPA Data",
                        buttonColor: AppColor.blue,
                        buttonTextColor: AppColor.white),
                    SizedBox(height: 18.h),
                    StudentAssessButton(
                        pressedAction: () {},
                        buttonText: "Update Profile Information",
                        buttonColor: AppColor.black,
                        buttonTextColor: AppColor.white),
                    SizedBox(height: 18.h),
                    StudentAssessButton(
                        pressedAction: () {},
                        buttonText: "Delete All Data",
                        buttonColor: Colors.red,
                        buttonTextColor: AppColor.white),
                    SizedBox(height: 18.h),

                    // Theme Toggle Card
                    const ThemeToggleCard(),

                    SizedBox(height: 18.h),

                    // Sign Out Button
                    StudentAssessButton(
                        pressedAction: () async {
                          await authProvider.signOut();
                          if (context.mounted) {
                            context.go(AppRoutes.authRoute);
                          }
                        },
                        buttonText: "Sign Out",
                        buttonColor: Colors.orange,
                        buttonTextColor: AppColor.white),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
