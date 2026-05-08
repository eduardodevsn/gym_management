import 'package:dio/dio.dart';
import 'package:gym_management/feature/auth/domain/entities/auth_token.dart';
import 'package:gym_management/feature/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<(User, AuthToken)> loginWithEmail({
    required String email,
    required String password,
  });

  Future<(User, AuthToken)> loginWithGoogle();

  Future<(User, AuthToken)> loginWithFacebook();

  Future<(User, AuthToken)> loginWithApple();

  Future<User?> getCurrentUser();

  Future<AuthToken> refreshToken(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio client;

  const AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<(User, AuthToken)> loginWithEmail({
    required String email,
    required String password,
  }) {
    throw UnimplementedError('loginWithEmail not implemented');
  }

  @override
  Future<(User, AuthToken)> loginWithGoogle() {
    throw UnimplementedError('loginWithGoogle not implemented');
  }

  @override
  Future<(User, AuthToken)> loginWithFacebook() {
    throw UnimplementedError('loginWithFacebook not implemented');
  }

  @override
  Future<(User, AuthToken)> loginWithApple() {
    throw UnimplementedError('loginWithApple not implemented');
  }

  @override
  Future<User?> getCurrentUser() {
    throw UnimplementedError('getCurrentUser not implemented');
  }

  @override
  Future<AuthToken> refreshToken(String token) {
    throw UnimplementedError('refreshToken not implemented');
  }
}
