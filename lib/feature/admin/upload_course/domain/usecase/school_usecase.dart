import 'package:ited_study_app_admin/feature/admin/upload_course/domain/repository/course_repository.dart';

class SchoolUsecase {
  final CourseRepository _courseRepository;

  SchoolUsecase(this._courseRepository);

  Future<void> school(String schoolName, String country) async {
    return await _courseRepository.school(schoolName, country);
  }
}
