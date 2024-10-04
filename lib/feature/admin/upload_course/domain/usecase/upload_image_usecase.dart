
import 'dart:typed_data';

import '../repository/course_repository.dart';

class UploadImageUsecase {
  final CourseRepository courseRepository;

  UploadImageUsecase(this.courseRepository);
  Future<String> uploadImage(Uint8List? image) async {
    return await courseRepository.uploadImage(image);
  }
}
