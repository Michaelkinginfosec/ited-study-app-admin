import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/usecase/country_usercase.dart';

import '../../../../../core/provider/providers.dart';

enum CountryStatus { initial, loading, error, success }

class CountryState {
  final CountryStatus status;
  final String? error;
  final String? message;
  CountryState({
    this.status = CountryStatus.initial,
    this.error,
    this.message,
  });
  CountryState copyWith({
    CountryStatus? status,
    String? error,
    String? message,
  }) {
    return CountryState(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}

class CountryNotifier extends StateNotifier<CountryState> {
  final CountryUsecase countryUsecase;
  CountryNotifier(this.countryUsecase) : super(CountryState());

  Future<void> country(String country) async {
    state = state.copyWith(status: CountryStatus.loading);
    try {
      await countryUsecase.country(country);
      state = state.copyWith(
        status: CountryStatus.success,
      );
    } catch (e) {
      state = state.copyWith(status: CountryStatus.error, error: e.toString());
      rethrow;
    }
  }
}

final countryNotifierProvider =
    StateNotifierProvider<CountryNotifier, CountryState>(
  (ref) {
    return CountryNotifier(ref.read(countryUsecaseProvider));
  },
);
