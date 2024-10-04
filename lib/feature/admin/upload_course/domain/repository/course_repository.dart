
import 'dart:typed_data';

abstract class CourseRepository {
  Future<void> createCourse(
    String school,
    String courseName,
    String courseTitle,
    String courseCode,
    Uint8List? courseImage,
  );
  Future<void> country(String country);
  Future<void> school(String schoolName, String country);
  Future<String> uploadImage(Uint8List? image);
}
