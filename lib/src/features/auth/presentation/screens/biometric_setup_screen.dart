import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/core/theme/app_text_styles.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/presentation/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/presentation/widgets/auth_screen_container.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:casino_platform_test/src/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

/// Screen for optional biometric one-tap login enrollment.
class BiometricSetupScreen extends StatelessWidget {
  /// Route path for biometric setup screen.
  static const String routePath = RoutePaths.biometricSetup;

  /// Creates [BiometricSetupScreen].
  const BiometricSetupScreen({super.key});

  Future<void> _onEnableTap(BuildContext context) async {
    await context.read<AuthCubit>().enableBiometric();
    if (!context.mounted) {
      return;
    }
    context.go(RoutePaths.shell);
  }

  void _onSkipTap(BuildContext context) {
    context.go(RoutePaths.shell);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return AuthScreenContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.h),
              Text(context.l10n.text('enableBiometricTitle'),
                  style: AppTextStyles.h1),
              SizedBox(height: 10.h),
              Text(
                context.l10n.text('enableBiometricDescription'),
                style: AppTextStyles.body,
              ),
              SizedBox(height: 20.h),
              AppButton(
                label: context.l10n.text('enableBiometric'),
                onPressed: state.biometricsAvailable
                    ? () => _onEnableTap(context)
                    : null,
                icon: Icons.fingerprint,
                isLoading: state.isBusy,
              ),
              SizedBox(height: 10.h),
              AppButton(
                label: context.l10n.text('skipForNow'),
                onPressed: () => _onSkipTap(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
