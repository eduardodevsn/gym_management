import 'package:dartz/dartz.dart';
import 'package:gym_management/core/usecases/usecase.dart';
import 'package:gym_management/feature/auth/domain/entities/auth_token.dart';
import 'package:gym_management/feature/auth/domain/entities/user.dart';
import 'package:gym_management/feature/auth/domain/repository/auth_repository.dart';

// Fake implementation for development. Replace with real API/Firebase when ready.
class FakeAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (email == 'test@gym.com' && password == '123456') {
      return Right((
        User(id: 'usr_1', email: email, name: 'Usuario Test', createdAt: DateTime.now()),
        AuthToken(
          accessToken: 'fake_access_token',
          refreshToken: 'fake_refresh_token',
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        ),
      ));
    }

    return Left(AuthFailure(message: 'Email o contraseña incorrectos', statusCode: 401));
  }

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithGoogle() async =>
      Left(AuthFailure(message: 'Google login no disponible', statusCode: 501));

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithFacebook() async =>
      Left(AuthFailure(message: 'Facebook login no disponible', statusCode: 501));

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithApple() async =>
      Left(AuthFailure(message: 'Apple login no disponible', statusCode: 501));

  @override
  Future<Either<Failure, User?>> getCurrentUser() async => const Right(null);

  @override
  Future<Either<Failure, void>> logout() async => const Right(null);

  @override
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken) async =>
      Left(AuthFailure(message: 'No implementado', statusCode: 501));

  @override
  Future<Either<Failure, void>> setRememberMe(bool value) async => const Right(null);

  @override
  Future<Either<Failure, bool>> getRememberMe() async => const Right(false);
}
