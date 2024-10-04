
import 'dart:typed_data';

import 'package:ited_study_app_admin/feature/admin/upload_course/domain/repository/course_repository.dart';


class CreateCourseUsecase {
  final CourseRepository _courseRepository;
  CreateCourseUsecase(this._courseRepository);

  Future<void> course( String school, String courseName,
      String courseTitle, String courseCode, Uint8List? courseImage) async {
    return await _courseRepository.createCourse(
      school,
      courseName,
      courseTitle,
      courseCode,
      courseImage,
    );
  }
}
