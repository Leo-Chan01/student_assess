import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/cgpa_calculator_provider.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/views/widgets/student_assess_textfield_widget.dart';

class CgpaRegisterScreen extends StatelessWidget {
  CgpaRegisterScreen({super.key});

  final _courseController = TextEditingController();

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
              Text(
                "Course Registration",
                style: 36.w700,
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
              ElevatedButton(
                onPressed: () {},
                child: const Text('Register Course'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cgpaProvider.courses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(cgpaProvider.courses[index].courseCode),
                      subtitle: Text(
                          'Credit Unit: ${cgpaProvider.courses[index].creditUnit}'),
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
