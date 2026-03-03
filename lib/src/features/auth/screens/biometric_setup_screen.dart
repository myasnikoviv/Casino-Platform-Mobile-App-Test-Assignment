import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/entities/biometric_setup_view_model.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/views/biometric_setup_view.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen that maps auth states and renders biometric setup view.
class CPBiometricSetupScreen extends StatelessWidget {
  /// Route path for biometric setup screen.
  static const String routePath = CPRoutePaths.biometricSetup;

  /// Creates [CPBiometricSetupScreen].
  const CPBiometricSetupScreen({super.key});

  Future<void> _onEnableTap(BuildContext context) async {
    await context.read<CPAuthCubit>().enableBiometric();
    if (!context.mounted) {
      return;
    }
    context.goSubRoute(CPRoutePaths.shell);
  }

  void _onSkipTap(BuildContext context) {
    context.goSubRoute(CPRoutePaths.shell);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CPAuthCubit, CPAuthState>(
      listenWhen: (CPAuthState previous, CPAuthState current) =>
          previous.status != current.status,
      listener: (BuildContext context, CPAuthState state) {
        if (state.status == CPAuthStatus.unauthenticated) {
          context.goSubRoute(CPRoutePaths.login);
        }
      },
      builder: (BuildContext context, CPAuthState state) {
        return switch (state.status) {
          CPAuthStatus.unknown => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          CPAuthStatus.unauthenticated => const SizedBox.shrink(),
          CPAuthStatus.authenticated => CPBiometricSetupView(
              viewModel: CPBiometricSetupViewModel(
                title: context.l10n.text('enableBiometricTitle'),
                description: context.l10n.text('enableBiometricDescription'),
                enableLabel: context.l10n.text('enableBiometric'),
                skipLabel: context.l10n.text('skipForNow'),
                canEnable: state.biometricsAvailable,
                isLoading: state.isBusy,
              ),
              onEnableTap: state.biometricsAvailable
                  ? () => _onEnableTap(context)
                  : null,
              onSkipTap: () => _onSkipTap(context),
            ),
        };
      },
    );
  }
}
