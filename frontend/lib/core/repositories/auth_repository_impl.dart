// lib/core/repositories/auth_repository_impl.dart
import 'package:dio/dio.dart';
import 'package:frontend/core/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository) // <-- Tell DI this is the implementation
class AuthRepositoryImpl implements IAuthRepository {
  final Dio _dio;

  // Dio is "injected" automatically by get_it
  AuthRepositoryImpl(this._dio);

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'] as String;
        // TODO: Save this token to secure storage
        return AuthSuccess(accessToken);
      } else {
        return AuthFailure('Login failed. Please try again.');
      }
    } on DioException catch (e) {
      return AuthFailure(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/auth/register',
        data: {
          'email': email,
          'password': password,
        },
      );
      // 201 Created
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }
}