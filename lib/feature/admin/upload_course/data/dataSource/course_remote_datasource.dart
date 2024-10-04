import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/course_entity.dart';
import '../model/course.dart';

abstract class CourseRemoteDatasource {
  Future<void> createCourse(String school, String courseName,
      String courseTitle, String courseCode, Uint8List courseImage);

  Future<void> country(String country);

  Future<void> school(String schoolName, String country);

  Future<String> uploadImage(Uint8List? image);
}

List<Map<String, String>> schoolList = [];

class CourseRemoteDatasourceImpl implements CourseRemoteDatasource {
  final Dio dio;

  CourseRemoteDatasourceImpl(this.dio);
  Future<String?> getCountryIdByName(String countryName) async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentCountryList =
        (box.get('countryList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();

    for (var country in currentCountryList) {
      if (country.containsKey(countryName)) {
        return country[countryName];
      }
    }

    return null;
  }

  Future<void> storeCountryName(
    String countryName,
  ) async {
    var box = Hive.box('notes');
    await box.put('countryName', countryName);
  }

  Future<void> storeCountry(String countryName, String countryId) async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentCountryList =
        (box.get('countryList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
    bool countryExists =
        currentCountryList.any((country) => country.containsKey(countryName));
    if (!countryExists) {
      currentCountryList.add({countryName: countryId});
    }

    await box.put("countryList", currentCountryList);
  }

  Future<String?> getSchoolById(String schoolName) async {
    var box = Hive.box('notes');
    List<Map<String, String>> currentSchoolList =
        (box.get('schoolList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
    for (var school in currentSchoolList) {
      if (school.containsKey(schoolName)) {
        return school[schoolName];
      }
    }
    return null;
  }

  Future<void> storeCourse(Course course) async {
    var box = Hive.box<CourseEntity>('courses');

    CourseEntity courseEntity = course.toEntity();

    await box.add(courseEntity);
  }

  Future<void> storeSchoolName(String schoolName) async {
    var box = Hive.box('notes');
    await box.put('schoolName', schoolName);
  }

  Future<void> storeSchool(String schoolName, String schoolId) async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentSchoolList =
        (box.get('schoolList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();
    bool schoolExists =
        currentSchoolList.any((school) => school.containsKey(schoolName));
    if (!schoolExists) {
      currentSchoolList.add({schoolName: schoolId});
    }
    await box.put('schoolList', currentSchoolList);
  }

  @override
  Future<void> createCourse(String school, String courseName,
      String courseTitle, String courseCode, Uint8List courseImage) async {
    String? schoolId = await getSchoolById(school);
    if (schoolId == null) {
      throw Exception('School not found');
    }

    try {
      String imageUrl = await uploadImage(courseImage);

      final response = await dio.post('/notes/create-course/$schoolId', data: {
        "courseName": courseName,
        "courseTitle": courseTitle,
        "courseCode": courseCode,
        "courseImage": imageUrl,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final courseName = responseData['name'] as String?;
          final courseTitle = responseData['title'] as String?;
          final courseCode = responseData['code'] as String?;
          final courseImage = responseData['image'] as String;

          if (courseName != null && courseTitle != null && courseCode != null) {
            Course newCourse = Course(
              courseName: courseName,
              courseTitle: courseTitle,
              courseCode: courseCode,
              courseImage: courseImage,
            );

            await storeCourse(newCourse);
          } else {
            throw Exception(response.data['message']);
          }
        }
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception(e.response!.data['message']);
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }

  @override
  Future<void> country(String country) async {
    try {
      final response = await dio.post(
        '/notes/create-country',
        data: {
          'country': country,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final countryId = responseData['countryId'] as String?;
          final countryName = responseData['country'] as String?;
          final message = responseData['message'] as String?;

          if (countryId != null && countryName != null && message != null) {
            await storeCountry(countryName, countryId);
            await storeCountryName(countryName);
          } else {
            throw Exception(response.data['message']);
          }
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.data['message']);
      }

      return response.data['message'];
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404) {
          if (e.response!.data['message'] == 'name is required') {
            throw Exception("Enter country name");
          }
          throw Exception(e.response!.data['message']);
        } else {
          throw Exception(e.response!.data['message']);
        }
      }
    } catch (e) {
      throw Exception('Unexpected error occured : $e');
    }
  }

  @override
  Future<void> school(String schoolName, String country) async {
    String? countryId = await getCountryIdByName(country);
    if (countryId == null) {
      throw Exception('Country not found');
    }
    try {
      final response = await dio.post(
        '/notes/create-school/',
        data: {
          'school': schoolName,
          'countryId': countryId,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final schoolName = responseData['school'] as String?;
          final schoolId = responseData['schoolId'] as String?;
          if (schoolId != null && schoolName != null) {
            await storeSchool(schoolName, schoolId);
            await storeSchoolName(schoolName);
          } else {
            throw Exception(response.data['message']);
          }
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400 || e.response!.statusCode == 404) {
          if (e.response!.data['message'] == 'name is required') {
            throw Exception("Enter school name");
          }
          throw Exception(e.response!.data['message']);
        } else {
          throw Exception(e.response!.data['message']);
        }
      }
    } catch (e) {
      throw Exception('Unexpected error occured : $e');
    }
  }

  @override
  Future<String> uploadImage(Uint8List? imageBytes) async {
    if (imageBytes == null) {
      throw Exception("Image is empty");
    }

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        imageBytes,
        filename: 'course_image.jpg',
      ),
    });

    try {
      final response = await dio.post('/notes/upload-image/', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final imageUrl = responseData['url'] as String?;
          if (imageUrl != null) {
            return imageUrl;
          } else {
            throw Exception('Image URL is missing in the response');
          }
        } else {
          throw Exception('Unexpected response format: ${response.data}');
        }
      } else {
        throw Exception('Failed to upload image: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response!.data['message'] ?? 'Unknown error occurred';
        throw Exception(message);
      } else {
        throw Exception('Network error occurred: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
