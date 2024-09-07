import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
                child: (cgpaProvider.courses.isNotEmpty)
                    ? ListView.builder(
                        itemCount: cgpaProvider.courses.length,
                        itemBuilder: (context, index) {
                          final course = cgpaProvider.courses[index];
                          return ListTile(
                            title: Text(course.courseCode),
                            subtitle: DropdownButton<String>(
                              value: cgpaProvider.selectedGrades[course],
                              items: cgpaProvider.grades.keys.map((grade) {
                                return DropdownMenuItem(
                                  value: grade,
                                  child: Text(
                                    grade,
                                    style: 28.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                cgpaProvider.updateSelectedGrade(course, value);
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No Courses registered yet!",
                          style: 18.w700,
                        ),
                      ),
              ),
              StudentAssessButton(
                  pressedAction: () {
                    if (cgpaProvider.courses.isNotEmpty) {
                      cgpaProvider.calculateCGPA();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content:
                              Text('Your CGPA is ${cgpaProvider.cgpa.toStringAsFixed(2)}'),
                        ),
                      );























                      
                    } else {}
                  },
                  buttonText: "Calculate CGPA",
                  buttonColor: cgpaProvider.courses.isNotEmpty
                      ? AppColor.blue
                      : AppColor.grey.withOpacity(0.1),
                  buttonTextColor: cgpaProvider.courses.isNotEmpty
                      ? AppColor.black
                      : AppColor.grey)
            ],
          ),
        ),
      ),
    );
  }
}
