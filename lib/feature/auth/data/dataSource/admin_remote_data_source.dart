import 'package:dio/dio.dart';

abstract class AdminRemoteDataSource {
  Future<String> login(String username, String password);
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final Dio dio;
  AdminRemoteDataSourceImpl(this.dio);
  @override
  Future<String> login(String username, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          final accessToken = responseData['accessToken'] as String;
          return accessToken;
        } else {
          throw Exception(response.data);
        }
      } else {
        throw Exception('Couldn\'t login ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          throw Exception('Wrong Credentials');
        } else {
          throw Exception(e.response!.data['message']);
        }
      } else {
        throw Exception(e.response!.data['message']);
      }
    } catch (e) {
      throw Exception('An unknown error occured: $e');
    }
  }
}
