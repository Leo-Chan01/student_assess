import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_assess/models/course_model.dart';
import 'package:student_assess/view_model/database/courses_model.dart'
    as hive_course;

class CgpaCalculatorProvider extends ChangeNotifier {
  CgpaCalculatorProvider() {
    getCoursesFromHive();
  }

  int _selectedCreditUnit = 1;
  int get selectedCreditUnit => _selectedCreditUnit;

  // ignore: prefer_final_fields
  List<Course> _courses = [];
  List<Course> get courses => _courses;

  List<hive_course.Course> _hiveCourses = [];
  List<hive_course.Course> get hiveCourses => _hiveCourses;

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

  // ignore: prefer_final_fields
  Map<hive_course.Course, String> _selectedGradesInHive = {};
  Map<hive_course.Course, String> get selectedGradesInHIve =>
      _selectedGradesInHive;

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

  void calculateCGPAHive() {
    double totalGP = 0;
    int totalCreditUnits = 0;

    for (var course in _hiveCourses) {
      int gradeValue = grades[selectedGradesInHIve[course]]!;
      totalGP += gradeValue * course.creditUnit;
      totalCreditUnits += course.creditUnit;
    }

    _cgpa = totalGP / totalCreditUnits;
    notifyListeners();
    log("CGPA is $_cgpa");
  }

  void updateSelectedGradeInHive(hive_course.Course course, String? value) {
    _selectedGradesInHive[course] = value!;
    notifyListeners();
  }

  void registerCourseToHive({required String courseCode}) async {
    hive_course.Course newCourse = hive_course.Course(
      courseCode: courseCode,
      creditUnit: _selectedCreditUnit,
      grade: 'N/A',
    );
    await addCourseToHive(newCourse);
  }

  Future<void> addCourseToHive(hive_course.Course course) async {
    _isRegisteringCourse = true;
    notifyListeners();
    var courseBox = await Hive.openBox<hive_course.Course>('coursesBox');
    await courseBox.add(course);
    _hiveCourses = courseBox.values.toList();
    log("Hive courses are $_hiveCourses");
    _isRegisteringCourse = false;
    notifyListeners();
  }

  void removeCourseFromHive(String courseCode) async {
    var courseBox = Hive.box<hive_course.Course>('coursesBox');

    final keyToDelete = courseBox.keys.firstWhere(
      (key) => courseBox.get(key)?.courseCode == courseCode,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await courseBox.delete(keyToDelete);
      notifyListeners();
      log('This course $courseCode deleted');
      log("Removed course $courseCode");
      _hiveCourses = courseBox.values.toList();
      notifyListeners();
      log("List of hive courses now is $_hiveCourses and in hive we have ${courseBox.values.toList()}");
    } else {
      log('Course not found');
    }
    log("Remaining Courses are ${courseBox.values.toList()}");
    notifyListeners();
  }

  void loadCoursesFromHive() async {
    _isFetching = true;
    notifyListeners();
    List<hive_course.Course> courses = await getCoursesFromHive();
    log('Courses: $courses');
    _isFetching = false;
    notifyListeners();
  }

  Future<List<hive_course.Course>> getCoursesFromHive() async {
    var box = await Hive.openBox<hive_course.Course>('coursesBox');
    _hiveCourses = box.values.toList();
    notifyListeners();
    log("Hive courses fetched are $_hiveCourses");
    return _hiveCourses;
  }
}
