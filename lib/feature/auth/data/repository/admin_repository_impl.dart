import 'package:ited_study_app_admin/feature/auth/data/dataSource/admin_remote_data_source.dart';
import 'package:ited_study_app_admin/feature/auth/domain/repository/repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final AdminRemoteDataSource _adminRemoteDataSource;
  AdminRepositoryImpl(this._adminRemoteDataSource);
  @override
  Future<String> login(String username, String password) async {
    return await _adminRemoteDataSource.login(username, password);
  }
}
