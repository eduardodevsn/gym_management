import 'package:equatable/equatable.dart';
import 'package:gym_management/feature/auth/domain/entities/user_type.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginRememberMeToggled extends LoginEvent {
  final bool value;

  const LoginRememberMeToggled(this.value);

  @override
  List<Object?> get props => [value];
}

class LoginUserTypeChanged extends LoginEvent {
  final UserType userType;

  const LoginUserTypeChanged(this.userType);

  @override
  List<Object?> get props => [userType];
}

class LoginSubmitted extends LoginEvent {}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithFacebookPressed extends LoginEvent {}

class LoginWithApplePressed extends LoginEvent {}

class LoadRememberMePreference extends LoginEvent {}
