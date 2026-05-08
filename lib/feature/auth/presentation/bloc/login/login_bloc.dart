import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/login_with_email_usecase.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/repository/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginWithEmailUseCase _loginUseCase;
  final AuthRepository _authRepository;
  
  LoginBloc({
    required LoginWithEmailUseCase loginUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _authRepository = authRepository,
        super(const LoginInitial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginRememberMeToggled>(_onRememberMeToggled);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginWithGooglePressed>(_onGoogleLogin);
    on<LoginWithFacebookPressed>(_onFacebookLogin);
    on<LoginWithApplePressed>(_onAppleLogin);
    on<LoadRememberMePreference>(_onLoadRememberMe);
  }
  

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final currentState = state;
    
    if (currentState is LoginValidationState) {
      final isValid = _validateEmail(event.email);
      final error = isValid ? null : 'Email inválido';
      
      emit(currentState.copyWith(
        email: event.email,
        isEmailValid: isValid,
        emailError: error,
      ));
    } else {
      emit(LoginValidationState(
        email: event.email,
        password: '',
        isEmailValid: _validateEmail(event.email),
        isPasswordValid: false,
        rememberMe: (state as LoginInitial).rememberMe,
        emailError: _validateEmail(event.email) ? null : 'Email inválido',
      ));
    }
  }
  
  void _onPasswordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    if (state is LoginValidationState) {
      final currentState = state as LoginValidationState;
      final isValid = _validatePassword(event.password);
      final error = isValid ? null : 'Mínimo 6 caracteres';
      
      emit(currentState.copyWith(
        password: event.password,
        isPasswordValid: isValid,
        passwordError: error,
      ));
    }
  }
  
  void _onRememberMeToggled(LoginRememberMeToggled event, Emitter<LoginState> emit) {
    if (state is LoginValidationState) {
      final currentState = state as LoginValidationState;
      emit(currentState.copyWith(rememberMe: event.value));
    } else if (state is LoginInitial) {
      emit(LoginInitial(rememberMe: event.value));
    }
    
    _authRepository.setRememberMe(event.value);
  }
  
  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state is! LoginValidationState) return;
    
    final currentState = state as LoginValidationState;
    
    if (!currentState.isFormValid) {
      emit(LoginError(
        AuthFailure(message: 'Por favor, completa los campos correctamente'),
      ));
      return;
    }
    
    emit(LoginLoading());
    
    final params = LoginParams(
      email: currentState.email,
      password: currentState.password,
      rememberMe: currentState.rememberMe,
    );
    
    final result = await _loginUseCase(params);
    
    result.fold(
      (failure) => emit(LoginError(failure)),
      (success) => emit(LoginSuccess(success.$1)),
    );
  }
  
  Future<void> _onGoogleLogin(LoginWithGooglePressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    final result = await _authRepository.loginWithGoogle();
    
    result.fold(
      (failure) => emit(LoginError(failure)),
      (success) => emit(LoginSuccess(success.$1)),
    );
  }
  
  Future<void> _onFacebookLogin(LoginWithFacebookPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    final result = await _authRepository.loginWithFacebook();
    
    result.fold(
      (failure) => emit(LoginError(failure)),
      (success) => emit(LoginSuccess(success.$1)),
    );
  }
  
  Future<void> _onAppleLogin(LoginWithApplePressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    final result = await _authRepository.loginWithApple();
    
    result.fold(
      (failure) => emit(LoginError(failure)),
      (success) => emit(LoginSuccess(success.$1)),
    );
  }
  
  Future<void> _onLoadRememberMe(LoadRememberMePreference event, Emitter<LoginState> emit) async {
    final result = await _authRepository.getRememberMe();
    
    result.fold(
      (failure) => null,
      (rememberMe) {
        if (state is LoginInitial) {
          emit(LoginInitial(rememberMe: rememberMe));
        }
      },
    );
  }
  
  bool _validateEmail(String email) {
    return email.isNotEmpty && 
           email.contains('@') && 
           email.contains('.') &&
           email.length >= 5;
  }
  
  bool _validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }
}