import 'package:flutter/material.dart';
import 'package:student_assess/models/course_model.dart';

class CgpaCalculatorProvider extends ChangeNotifier {
  int _selectedCreditUnit = 1;
  int get selectedCreditUnit => _selectedCreditUnit;

  // ignore: prefer_final_fields
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  updateSelectedCreditUnit(int value) {
    _selectedCreditUnit = value;
    notifyListeners();
  }

  void registerCourse({required String courseCode}) {
    _courses.add(Course(
      courseCode: courseCode,
      creditUnit: _selectedCreditUnit,
    ));
    notifyListeners();
  }
}
