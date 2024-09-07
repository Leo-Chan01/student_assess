import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/cgpa_calculator_provider.dart';
import 'package:student_assess/views/widgets/student_assess_textfield_widget.dart';

class CgpaRegisterScreen extends StatelessWidget {
  CgpaRegisterScreen({super.key});

  final _courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var cgpaProvider = context.watch<CgpaCalculatorProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Course Registration"),
            StudentAssessTextField(
              inputcontroller: _courseController,
              hintText: "Course Code",
              maxLinesNeeded: 1,
              inputType: TextInputType.name,
            ),
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
            ),
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
    );
  }
}
