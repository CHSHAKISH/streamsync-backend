// lib/core/repositories/auth_repository.dart


abstract class AuthResult {}
class AuthSuccess extends AuthResult {
  final String accessToken;
  AuthSuccess(this.accessToken);
}
class AuthFailure extends AuthResult {
  final String message;
  AuthFailure(this.message);
}

abstract class IAuthRepository {
  Future<AuthResult> login({
    required String email,
    required String password,
  });

  Future<bool> register({
    required String email,
    required String password,
  });
}