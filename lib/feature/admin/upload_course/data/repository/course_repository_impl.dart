import 'dart:typed_data';

import 'package:ited_study_app_admin/feature/admin/upload_course/data/dataSource/course_remote_datasource.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/repository/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDatasource remoteDatasource;

  CourseRepositoryImpl(this.remoteDatasource);

  @override
  Future<void> createCourse(
    school,
    String courseName,
    String courseTitle,
    String courseCode,
    Uint8List? courseImage,
  ) async {
    return await remoteDatasource.createCourse(
      school,
      courseName,
      courseTitle,
      courseCode,
      courseImage!,
    );
  }

  @override
  Future<void> country(String country) async {
    return await remoteDatasource.country(country);
  }

  @override
  Future<void> school(String schoolName, String country) async {
    return await remoteDatasource.school(schoolName, country);
  }

  @override
  Future<String> uploadImage(Uint8List? image) async {
    return await remoteDatasource.uploadImage(image);
  }
}
