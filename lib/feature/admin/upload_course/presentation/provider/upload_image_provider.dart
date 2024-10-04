import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/usecase/upload_image_usecase.dart';

import '../../../../../core/provider/providers.dart';

enum UploadImageStatus { initial, loading, success, error }

class UploadImageState {
  final UploadImageStatus status;
  final String? message;
  final String? error;

  UploadImageState({
    this.status = UploadImageStatus.initial,
    this.message,
    this.error,
  });

  UploadImageState copyWith({
    UploadImageStatus? status,
    String? message,
    String? error,
  }) {
    return UploadImageState(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}

class UploadImageNotifier extends StateNotifier<UploadImageState> {
  final UploadImageUsecase uploadImageUsecase;
  UploadImageNotifier(this.uploadImageUsecase) : super(UploadImageState());
  Future<void> uploadImage(Uint8List? image) async {
    state = state.copyWith(status: UploadImageStatus.loading);
    try {
      await uploadImageUsecase.uploadImage(image);
      state = state.copyWith(status: UploadImageStatus.success);
    } catch (e) {
      state =
          state.copyWith(status: UploadImageStatus.error, error: e.toString());
    }
  }
}

final uploadImageNotifierProvider =
    StateNotifierProvider<UploadImageNotifier, UploadImageState>((ref) {
  return UploadImageNotifier(ref.watch(uploadImageUsecaseProvider));
});
