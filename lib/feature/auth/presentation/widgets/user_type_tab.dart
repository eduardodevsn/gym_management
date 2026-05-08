import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/core/themes/app_colors.dart';
import 'package:gym_management/feature/auth/domain/entities/user_type.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class UserTypeTab extends StatelessWidget {
  const UserTypeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => _userType(prev) != _userType(curr),
      builder: (context, state) {
        final active = _userType(state);
        return Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: UserType.values.map((type) {
              final isActive = type == active;
              return Expanded(
                child: GestureDetector(
                  onTap: () => context.read<LoginBloc>().add(LoginUserTypeChanged(type)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      type.label,
                      style: TextStyle(
                        color: isActive ? Colors.white : AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  UserType _userType(LoginState state) {
    if (state is LoginValidationState) return state.userType;
    if (state is LoginInitial) return state.userType;
    return UserType.user;
  }
}
