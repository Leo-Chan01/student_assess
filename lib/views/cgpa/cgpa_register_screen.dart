import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/cgpa_calculator_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/config/routes.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/views/widgets/student_assess_button_widget.dart';
import 'package:student_assess/views/widgets/student_assess_textfield_widget.dart';

class CgpaRegisterScreen extends StatelessWidget {
  const CgpaRegisterScreen({super.key});

  static final _courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cgpaProvider = context.watch<CgpaCalculatorProvider>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 28.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(
                    onPressed: () {
                      context.go(AppRoutes.homeRoute);
                    },
                  ),
                  Flexible(
                    child: Text(
                      "Course Registration",
                      style: 32.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              StudentAssessTextField(
                inputcontroller: _courseController,
                hintText: "Course Code",
                maxLinesNeeded: 1,
                inputType: TextInputType.name,
              ),
              SizedBox(height: 18.h),
              DropdownButton<int>(
                value: cgpaProvider.selectedCreditUnit,
                items: List.generate(
                    6,
                    (index) => DropdownMenuItem(
                          value: index + 1,
                          child: Text('${index + 1} Credit Unit'),
                        )),
                onChanged: (value) {
                  cgpaProvider.updateSelectedCreditUnit(value!);
                },
                elevation: 0,
                alignment: Alignment.bottomRight,
                borderRadius: BorderRadius.circular(12.r),
                underline: const SizedBox.shrink(),
              ),
              SizedBox(height: 18.h),
              StudentAssessButton(
                  pressedAction: () {
                    String courseCode =
                        _courseController.text.trim().toString();
                    if (courseCode.isEmpty) {
                    } else {
                      cgpaProvider.registerCourseToHive(
                          courseCode: _courseController.text.trim().toString());
                    }
                  },
                  buttonText: "Register Course",
                  buttonColor: AppColor.black,
                  buttonTextColor: AppColor.white),
              Expanded(
                child: ListView.builder(
                  itemCount: cgpaProvider.hiveCourses.length,
                  itemBuilder: (context, index) {
                    log("Hive courses are ${cgpaProvider.hiveCourses[index].courseCode}");
                    return ListTile(
                      title: Text(
                        cgpaProvider.hiveCourses[index].courseCode,
                        style: 18.w600,
                      ),
                      subtitle: Text(
                        'Credit Unit: ${cgpaProvider.hiveCourses[index].creditUnit}',
                        style: 14.w400,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          cgpaProvider.removeCourseFromHive(
                              cgpaProvider.hiveCourses[index].courseCode);
                        },
                        child: const Icon(
                          CupertinoIcons.minus,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
