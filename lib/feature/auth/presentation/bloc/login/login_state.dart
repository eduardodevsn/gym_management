import 'package:equatable/equatable.dart';
import 'package:gym_management/core/usecases/usecase.dart';
import 'package:gym_management/feature/auth/domain/entities/user.dart';
import 'package:gym_management/feature/auth/domain/entities/user_type.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  final bool rememberMe;
  final UserType userType;

  const LoginInitial({
    this.rememberMe = false,
    this.userType = UserType.user,
  });

  @override
  List<Object?> get props => [rememberMe, userType];
}

class LoginLoading extends LoginState {}

class LoginValidationState extends LoginState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool rememberMe;
  final UserType userType;
  final String? emailError;
  final String? passwordError;

  const LoginValidationState({
    required this.email,
    required this.password,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.rememberMe,
    this.userType = UserType.user,
    this.emailError,
    this.passwordError,
  });

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginValidationState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? rememberMe,
    UserType? userType,
    String? emailError,
    String? passwordError,
  }) {
    return LoginValidationState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      rememberMe: rememberMe ?? this.rememberMe,
      userType: userType ?? this.userType,
      emailError: emailError,
      passwordError: passwordError,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        isEmailValid,
        isPasswordValid,
        rememberMe,
        userType,
        emailError,
        passwordError,
      ];
}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginError extends LoginState {
  final Failure failure;

  const LoginError(this.failure);

  String get message => failure.message;

  @override
  List<Object?> get props => [failure];
}
