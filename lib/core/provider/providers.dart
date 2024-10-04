import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/data/dataSource/course_remote_datasource.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/data/repository/course_repository_impl.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/repository/course_repository.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/domain/usecase/create_course_usecase.dart';
import 'package:ited_study_app_admin/feature/auth/data/dataSource/admin_remote_data_source.dart';
import 'package:ited_study_app_admin/feature/auth/data/repository/admin_repository_impl.dart';
import 'package:ited_study_app_admin/feature/auth/domain/repository/repository.dart';
import 'package:ited_study_app_admin/feature/auth/domain/usecase/login_usecase.dart';

import '../../feature/admin/upload_course/domain/usecase/country_usercase.dart';
import '../../feature/admin/upload_course/domain/usecase/school_usecase.dart';
import '../../feature/admin/upload_course/domain/usecase/upload_image_usecase.dart';

final screenProvider = StateProvider<int>((ref) => 0);

final dioProvider = Provider<Dio>(
  (ref) {
    return Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? '',
      ),
    );
  },
);

final courseRemoteDataProvider = Provider<CourseRemoteDatasource>(
  (ref) {
    return CourseRemoteDatasourceImpl(
      ref.read(dioProvider),
    );
  },
);
final adminRemoteDataProvider = Provider<AdminRemoteDataSource>(
  (ref) {
    return AdminRemoteDataSourceImpl(
      ref.read(dioProvider),
    );
  },
);

final courseRepositoryProvider = Provider<CourseRepository>(
  (ref) {
    return CourseRepositoryImpl(
      ref.read(courseRemoteDataProvider),
    );
  },
);
final adminRepositoryProvider = Provider<AdminRepository>(
  (ref) {
    return AdminRepositoryImpl(ref.read(adminRemoteDataProvider));
  },
);

final createCourseUsecaseProvider = Provider<CreateCourseUsecase>(
  (ref) {
    return CreateCourseUsecase(ref.read(courseRepositoryProvider));
  },
);

final countryUsecaseProvider = Provider<CountryUsecase>(
  (ref) {
    return CountryUsecase(ref.read(courseRepositoryProvider));
  },
);

final schoolUsecaseProvider = Provider<SchoolUsecase>((ref) {
  return SchoolUsecase(ref.read(courseRepositoryProvider));
});
final uploadImageUsecaseProvider = Provider<UploadImageUsecase>((ref) {
  return UploadImageUsecase(ref.read(courseRepositoryProvider));
});

final loginUsecaseProvider = Provider<LoginUsecase>((ref) {
  return LoginUsecase(
    ref.read(adminRepositoryProvider),
  );
});
//Local Database 