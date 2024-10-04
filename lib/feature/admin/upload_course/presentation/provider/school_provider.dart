import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/provider/providers.dart';
import '../../domain/usecase/school_usecase.dart';

enum SchoolStatus { initial, loading, error, success }

class SchoolState {
  final SchoolStatus status;
  final String? error;
  final String? message;

  SchoolState({this.status = SchoolStatus.initial, this.error, this.message});

  SchoolState copyWith({
    SchoolStatus? status,
    String? error,
    String? message,
  }) {
    return SchoolState(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}

class SchoolNotifier extends StateNotifier<SchoolState> {
  final SchoolUsecase schoolUserCase;

  SchoolNotifier(this.schoolUserCase) : super(SchoolState());

  Future<void> school(String school, String country) async {
    state = state.copyWith(status: SchoolStatus.loading);
    try {
      await schoolUserCase.school(school, country);
      state = state.copyWith(status: SchoolStatus.success);
    } catch (e) {
      state = state.copyWith(status: SchoolStatus.error, error: e.toString());
    }
  }
}

final schoolNotifierProvider =
    StateNotifierProvider<SchoolNotifier, SchoolState>(
  (ref) {
    return SchoolNotifier(ref.read(schoolUsecaseProvider));
  },
);
