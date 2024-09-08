import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/database/courses_model.dart';
import 'package:student_assess/view_model/providers/cgpa_calculator_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/views/widgets/student_assess_button_widget.dart';

class CgpaCalculateScreen extends StatelessWidget {
  const CgpaCalculateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cgpaProvider = context.watch<CgpaCalculatorProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 28.sp),
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      context.go(AppRoutes.homeRoute);
                    },
                  ),
                  Text("Calculate your CGPA", style: 36.w700),
                ],
              ),
              Expanded(
                  child: FutureBuilder(
                      future: Hive.openBox<Course>("coursesBox"),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          if (cgpaProvider.hiveCourses.isEmpty) {
                            return Center(
                              child: Text(
                                "No Courses registered yet!",
                                style: 18.w700,
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: cgpaProvider.hiveCourses.length,
                              itemBuilder: (context, index) {
                                final course = cgpaProvider.hiveCourses[index];
                                return ListTile(
                                  contentPadding:
                                      EdgeInsetsDirectional.symmetric(
                                          vertical: 8.sp),
                                  title: Text(
                                    course.courseCode,
                                    style: 18.w600,
                                  ),
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                        color: AppColor.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: DropdownButton<String>(
                                      value: cgpaProvider
                                          .selectedGradesInHIve[course],
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      borderRadius: BorderRadius.circular(12.r),
                                      alignment: Alignment.bottomCenter,
                                      elevation: 0,
                                      menuWidth: 100.w,
                                      items:
                                          cgpaProvider.grades.keys.map((grade) {
                                        return DropdownMenuItem(
                                          value: grade,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.sp),
                                            child: Text(
                                              grade,
                                              style: 28.w400,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        cgpaProvider.updateSelectedGradeInHive(
                                            course, value);
                                      },
                                    ),
                                  ),
                                  trailing: Text(
                                    "${course.creditUnit} Credit Unit",
                                    style: 16.w400,
                                  ),
                                  titleAlignment: ListTileTitleAlignment.center,
                                );
                              },
                            );
                          }
                        }
                      })),
              StudentAssessButton(
                  pressedAction: () {
                    if (cgpaProvider.hiveCourses.isNotEmpty) {
                      cgpaProvider.calculateCGPAHive();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          elevation: 0,
                          content: Text(
                            'Your CGPA is ${cgpaProvider.cgpa.toStringAsFixed(2)}',
                            style: 20.w400,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {}
                  },
                  buttonText: "Calculate CGPA",
                  buttonColor: cgpaProvider.hiveCourses.isNotEmpty
                      ? AppColor.blue
                      : AppColor.grey.withOpacity(0.1),
                  buttonTextColor: cgpaProvider.hiveCourses.isNotEmpty
                      ? AppColor.black
                      : AppColor.grey)
            ],
          ),
        ),
      ),
    );
  }
}
