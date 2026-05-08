import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/core/themes/app_colors.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) {
        if (curr is LoginValidationState && prev is LoginValidationState) {
          return curr.email != prev.email || curr.emailError != prev.emailError;
        }
        return curr is LoginValidationState;
      },
      builder: (context, state) {
        final errorText = state is LoginValidationState ? state.emailError : null;
        return TextFormField(
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 15),
          decoration: _decoration('Email', 'usuario@ejemplo.com', Icons.email_outlined, errorText),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (v) => context.read<LoginBloc>().add(LoginEmailChanged(v)),
        );
      },
    );
  }
}

InputDecoration _decoration(
  String label,
  String hint,
  IconData icon,
  String? errorText,
) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
    hintText: hint,
    hintStyle: const TextStyle(color: AppColors.textHint),
    prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
    errorText: errorText,
    errorStyle: const TextStyle(color: AppColors.primary),
    filled: true,
    fillColor: AppColors.surface,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
  );
}
