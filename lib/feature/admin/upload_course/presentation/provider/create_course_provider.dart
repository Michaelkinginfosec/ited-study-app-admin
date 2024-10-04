
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/core/provider/providers.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/usecase/create_course_usecase.dart';



enum CreateCourseStatus { initial, success, loading, error }

class CreateCourseState {
  final CreateCourseStatus status;
  final String? message;
  final String? error;
  CreateCourseState({
    this.status = CreateCourseStatus.initial,
    this.message,
    this.error,
  });

  CreateCourseState copyWith({
    CreateCourseStatus? status,
    String? message,
    String? error,
  }) {
    return CreateCourseState(
        status: status ?? this.status,
        message: message ?? this.message,
        error: error ?? this.error);
  }
}

class CreateCourseNotifier extends StateNotifier<CreateCourseState> {
  final CreateCourseUsecase createCourseUsecase;
  CreateCourseNotifier(this.createCourseUsecase) : super(CreateCourseState());

  Future<void> createCourse(String school, String courseName,
      String courseTitle, String courseCode, Uint8List? courseImage) async {
    state = state.copyWith(status: CreateCourseStatus.loading);
    try {
      await createCourseUsecase.course(
       school,
        courseName,
        courseTitle,
        courseCode,
        courseImage,
      );
      state = state.copyWith(status: CreateCourseStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: CreateCourseStatus.error,
        error: e.toString(),
      );
    }
  }
}

final createCourseNotifierProvider =
    StateNotifierProvider<CreateCourseNotifier, CreateCourseState>((ref) {
  return CreateCourseNotifier(ref.read(createCourseUsecaseProvider));
});
