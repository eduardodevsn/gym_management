import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_management/core/themes/app_colors.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

typedef RememberMeCheckbox = RememberMeRow;

class RememberMeRow extends StatelessWidget {
  const RememberMeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) => _rememberMe(prev) != _rememberMe(curr),
      builder: (context, state) {
        final checked = _rememberMe(state);
        return GestureDetector(
          onTap: () => context.read<LoginBloc>().add(LoginRememberMeToggled(!checked)),
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: checked,
                  onChanged: (v) =>
                      context.read<LoginBloc>().add(LoginRememberMeToggled(v ?? false)),
                  checkColor: Colors.white,
                  fillColor: WidgetStateProperty.resolveWith(
                    (states) => states.contains(WidgetState.selected)
                        ? AppColors.primary
                        : Colors.transparent,
                  ),
                  side: const BorderSide(color: AppColors.border, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Recordarme',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _rememberMe(LoginState state) {
    if (state is LoginValidationState) return state.rememberMe;
    if (state is LoginInitial) return state.rememberMe;
    return false;
  }
}