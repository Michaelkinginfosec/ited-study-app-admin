import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/core/provider/providers.dart';
import 'package:ited_study_app_admin/feature/auth/domain/usecase/login_usecase.dart';

enum LoginStatus { initial, success, loading, error }

class LoginState {
  final LoginStatus status;
  final String? error;
  final String? message;

  const LoginState({
    this.status = LoginStatus.initial,
    this.error,
    this.message,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUsecase loginUsecase;
  LoginNotifier(this.loginUsecase) : super(LoginState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(status: LoginStatus.loading);
    try {
      await loginUsecase.login(username, password);
      state = state.copyWith(status: LoginStatus.success);
    } catch (e) {
      state = state.copyWith(status: LoginStatus.error, error: e.toString());
      rethrow;
    }
  }
}

final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(
    ref.read(loginUsecaseProvider),
  );
});
