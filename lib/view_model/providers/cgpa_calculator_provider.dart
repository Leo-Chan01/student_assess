import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_assess/models/course_model.dart';

class CgpaCalculatorProvider extends ChangeNotifier {
  int _selectedCreditUnit = 1;
  int get selectedCreditUnit => _selectedCreditUnit;

  // ignore: prefer_final_fields
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  double _cgpa = 0;
  double get cgpa => _cgpa;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isRegisteringCourse = false;
  bool get isRegisteringCourse => _isRegisteringCourse;

  final Map<String, int> _grades = {
    'A': 5,
    'B': 4,
    'C': 3,
    'D': 2,
    'E': 1,
    'F': 0,
  };

  Map<String, int> get grades => _grades;

  // ignore: prefer_final_fields
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

    _cgpa = totalGP / totalCreditUnits;
    notifyListeners();
    log("CGPA is $_cgpa");
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

  //HIVE ADDITION

  Future<void> addCourse(Course course) async {
    _isRegisteringCourse = true;
    notifyListeners();
    var box = await Hive.openBox<Course>('coursesBox');
    await box.add(course);
    _isRegisteringCourse = false;
    notifyListeners();
  }

  Future<List<Course>> getCourses() async {
    var box = await Hive.openBox<Course>('coursesBox');
    return box.values.toList();
  }

  void registerCourseToHive(
      String courseCode, int creditUnit, String grade) async {
    Course newCourse = Course(
      courseCode: courseCode,
      creditUnit: creditUnit,
      grade: grade,
    );
    await addCourse(newCourse);
  }

  void loadCourses() async {
    _isFetching = true;
    notifyListeners();
    List<Course> courses = await getCourses();
    log('Courses: $courses');
    _isFetching = false;
    notifyListeners();
  }
}
