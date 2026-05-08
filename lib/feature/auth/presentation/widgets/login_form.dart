import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/core/themes/app_colors.dart';
import 'package:gym_management/feature/auth/presentation/widgets/remember_me_row.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';
import 'user_type_tabs.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LoginSuccess || current is LoginError,
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.primary,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserTypeTabs(),
            
            const SizedBox(height: 24),
            
            const EmailInputField(),
            
            const SizedBox(height: 16),
            
            const PasswordInputField(),
            
            const SizedBox(height: 16),
            
            Row(
              children: [
                const RememberMeCheckbox(),
                const Spacer(),
                TextButton(
                  onPressed: isLoading ? null : () {
                    Navigator.of(context).pushNamed('/forgot-password');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    '¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 28),
            
            ElevatedButton(
              onPressed: isLoading || (state is LoginValidationState && !state.isFormValid)
                  ? null
                  : () => context.read<LoginBloc>().add(LoginSubmitted()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.login, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'INICIAR SESIÓN',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }
}