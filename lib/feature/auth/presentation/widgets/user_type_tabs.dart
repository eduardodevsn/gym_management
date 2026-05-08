import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/core/themes/app_colors.dart';
import 'package:gym_management/feature/auth/domain/entities/user_type.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class UserTypeTabs extends StatelessWidget {
  const UserTypeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        UserType selectedType = UserType.user;
        
        if (state is LoginInitial) {
          selectedType = state.userType;
        } else if (state is LoginValidationState) {
          selectedType = state.userType;
        }
        
        return Row(
          children: [
            Expanded(
              child: _UserTypeTab(
                label: 'USUARIO',
                icon: Icons.person_outline,
                isSelected: selectedType == UserType.user,
                onTap: () => context.read<LoginBloc>().add(
                  const LoginUserTypeChanged(UserType.user),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _UserTypeTab(
                label: 'COACH',
                icon: Icons.shield_outlined,
                isSelected: selectedType == UserType.coach,
                onTap: () => context.read<LoginBloc>().add(
                  const LoginUserTypeChanged(UserType.coach),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UserTypeTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _UserTypeTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}