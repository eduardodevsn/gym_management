import 'package:dartz/dartz.dart';
import 'package:gym_management/feature/auth/domain/entities/auth_token.dart';
import 'package:gym_management/feature/auth/domain/entities/user.dart';
import 'package:gym_management/feature/auth/domain/repository/auth_repository.dart';
import '../../../../core/usecases/usecase.dart';


class LoginParams {
  final String email;
  final String password;
  final bool rememberMe;
  
  const LoginParams({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
  
  bool get isValidEmail => email.isNotEmpty && email.contains('@');
  bool get isValidPassword => password.isNotEmpty && password.length >= 6;
  bool get isValid => isValidEmail && isValidPassword;
}

class LoginWithEmailUseCase implements UseCase<(User, AuthToken), LoginParams> {
  final AuthRepository _repository;
  
  LoginWithEmailUseCase(this._repository);
  
  @override
  Future<Either<Failure, (User, AuthToken)>> call(LoginParams params) async {
    if (!params.isValid) {
      return Left(
        AuthFailure(
          message: 'Email o contraseña inválidos',
          statusCode: 400,
        ),
      );
    }
    
    return _repository.loginWithEmail(
      email: params.email.trim().toLowerCase(),
      password: params.password,
      rememberMe: params.rememberMe,
    );
  }
}