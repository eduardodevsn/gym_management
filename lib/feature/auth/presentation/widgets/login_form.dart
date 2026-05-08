import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/feature/auth/presentation/widgets/remember_me_row.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import 'email_input_field.dart';
import 'password_input_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => current is LoginSuccess || current is LoginError,
      listener: (context, state) {
        if (state is LoginSuccess) {
          // Navegar a Home
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is LoginError) {
          // Mostrar SnackBar con error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
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
            // Campo Email
            const EmailInputField(),
            
            const SizedBox(height: 16),
            
            // Campo Contraseña
            const PasswordInputField(),
            
            const SizedBox(height: 12),
            
            // Recordarme y Olvidó contraseña
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const RememberMeCheckbox(),
                TextButton(
                  onPressed: isLoading ? null : () {
                    // Navegar a recuperar contraseña
                    Navigator.of(context).pushNamed('/forgot-password');
                  },
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Botón Iniciar Sesión
            ElevatedButton(
              onPressed: isLoading || (state is LoginValidationState && !state.isFormValid)
                  ? null
                  : () => context.read<LoginBloc>().add(LoginSubmitted()),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        );
      },
    );
  }
}