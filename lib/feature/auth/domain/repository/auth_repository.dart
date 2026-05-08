import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_token.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, (User, AuthToken)>> loginWithEmail({
    required String email,
    required String password,
    required bool rememberMe,
  });
  
  Future<Either<Failure, (User, AuthToken)>> loginWithGoogle();
  
  Future<Either<Failure, (User, AuthToken)>> loginWithFacebook();
  
  Future<Either<Failure, (User, AuthToken)>> loginWithApple();
  
  Future<Either<Failure, User?>> getCurrentUser();
  
  Future<Either<Failure, void>> logout();
  
  Future<Either<Failure, AuthToken>> refreshToken(String refreshToken);
  
  Future<Either<Failure, void>> setRememberMe(bool value);
  
  Future<Either<Failure, bool>> getRememberMe();
}