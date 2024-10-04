import 'package:ited_study_app_admin/feature/auth/domain/repository/repository.dart';

class LoginUsecase {
  final AdminRepository _adminRepository;
  LoginUsecase(this._adminRepository);

  Future<String> login(String email, String password) async {
    return await _adminRepository.login(email, password);
  }
}
