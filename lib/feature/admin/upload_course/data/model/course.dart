// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ited_study_app_admin/feature/admin/upload_course/domain/entities/course_entity.dart';

class Course {
  final String courseName;
  final String courseTitle;
  final String courseCode;
  final String courseImage;
  Course({
    required this.courseName,
    required this.courseTitle,
    required this.courseCode,
    required this.courseImage,
  });

  Course copyWith({
    String? courseName,
    String? courseTitle,
    String? courseCode,
    String? courseImage,
  }) {
    return Course(
      courseName: courseName ?? this.courseName,
      courseTitle: courseTitle ?? this.courseTitle,
      courseCode: courseCode ?? this.courseCode,
      courseImage: courseImage ?? this.courseImage,
    );
  }

  CourseEntity toEntity() {
    return CourseEntity(
      courseName: courseName,
      courseTitle: courseTitle,
      courseCode: courseCode,
      courseImage: courseImage,
    );
  }

  static Course fromEntity(CourseEntity entity) {
    return Course(
      courseName: entity.courseName,
      courseTitle: entity.courseTitle,
      courseCode: entity.courseCode,
      courseImage: entity.courseImage,
    );
  }
}
