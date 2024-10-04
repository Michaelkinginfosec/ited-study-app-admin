import 'dart:convert';
import 'package:hive/hive.dart';

part 'course_entity.g.dart';

@HiveType(typeId: 1)
class CourseEntity {
  @HiveField(0)
  final String courseName;

  @HiveField(1)
  final String courseTitle;

  @HiveField(2)
  final String courseCode;

  @HiveField(3)
  final String courseImage;

  CourseEntity({
    required this.courseName,
    required this.courseTitle,
    required this.courseCode,
    required this.courseImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'courseName': courseName,
      'courseTitle': courseTitle,
      'courseCode': courseCode,
      'courseImage': courseImage
    };
  }

  factory CourseEntity.fromMap(Map<String, dynamic> map) {
    return CourseEntity(
        courseName: map['courseName'] as String,
        courseTitle: map['courseTitle'] as String,
        courseCode: map['courseCode'] as String,
        courseImage: map['courseImage'] as String);
  }

  String toJson() => json.encode(toMap());

  factory CourseEntity.fromJson(String source) =>
      CourseEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseEntity(courseName: $courseName, courseTitle: $courseTitle, courseCode: $courseCode, courseImage: $courseImage)';
  }
}
