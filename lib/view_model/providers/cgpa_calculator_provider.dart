import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_assess/models/course_model.dart';

class CgpaCalculatorProvider extends ChangeNotifier {
  int _selectedCreditUnit = 1;
  int get selectedCreditUnit => _selectedCreditUnit;

  // ignore: prefer_final_fields
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  final Map<String, int> _grades = {
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0,
  };

  Map<String, int> get grades => _grades;

  Map<Course, String> _selectedGrades = {};
  Map<Course, String> get selectedGrades => _selectedGrades;

  void calculateCGPA() {
    double totalGP = 0;
    int totalCreditUnits = 0;

    for (var course in _courses) {
      int gradeValue = grades[selectedGrades[course]]!;
      totalGP += gradeValue * course.creditUnit;
      totalCreditUnits += course.creditUnit;
    }

    double cgpa = totalGP / totalCreditUnits;

    // return cgpa;
  }

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

  void removeCourse(String courseCode) {
    log("Removed course $courseCode");
    _courses.removeWhere((item) => item.courseCode == courseCode);
    notifyListeners();
    log("List of courses now is $_courses");
  }

  void updateSelectedGrade(Course course, String? value) {
    _selectedGrades[course] = value!;
    notifyListeners();
  }
}
