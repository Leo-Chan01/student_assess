import 'package:hive/hive.dart';

part 'courses_model.g.dart';  // For code generation

@HiveType(typeId: 0)
class Course {
  @HiveField(0)
  final String courseCode;

  @HiveField(1)
  final int creditUnit;

  @HiveField(2)
  final String grade;

  Course({
    required this.courseCode,
    required this.creditUnit,
    required this.grade,
  });
}
