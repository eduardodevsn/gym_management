import 'package:dartz/dartz.dart';
import 'package:gym_management/core/usecases/usecase.dart';
import 'package:gym_management/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:gym_management/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:gym_management/feature/auth/domain/entities/auth_token.dart';
import 'package:gym_management/feature/auth/domain/entities/user.dart';
import 'package:gym_management/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final result = await remoteDataSource.loginWithEmail(
        email: email,
        password: password,
      );
      if (rememberMe) await localDataSource.cacheToken(result.$2);
      await localDataSource.setRememberMe(rememberMe);
      return Right(result);
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithGoogle() async {
    try {
      return Right(await remoteDataSource.loginWithGoogle());
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithFacebook() async {
    try {
      return Right(await remoteDataSource.loginWithFacebook());
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, (User, AuthToken)>> loginWithApple() async {
    try {
      return Right(await remoteDataSource.loginWithApple());
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      return Right(await remoteDataSource.getCurrentUser());
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearCache();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken) async {
    try {
      return Right(await remoteDataSource.refreshToken(refreshToken));
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> setRememberMe(bool value) async {
    try {
      await localDataSource.setRememberMe(value);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, bool>> getRememberMe() async {
    try {
      return Right(await localDataSource.getRememberMe());
    } catch (e) {
      return Left(AuthFailure(message: e.toString(), statusCode: 500));
    }
  }
}
