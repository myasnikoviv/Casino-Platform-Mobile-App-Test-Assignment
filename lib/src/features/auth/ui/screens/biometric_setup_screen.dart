import 'package:casino_platform_test/src/core/router/extensions/context.dart';
import 'package:casino_platform_test/src/core/router/route_paths.dart';
import 'package:casino_platform_test/src/features/auth/ui/view_models/biometric_setup_view_model.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_cubit.dart';
import 'package:casino_platform_test/src/features/auth/cubit/auth_state.dart';
import 'package:casino_platform_test/src/features/auth/ui/screens/login_screen.dart';
import 'package:casino_platform_test/src/features/auth/ui/views/biometric_setup_view.dart';
import 'package:casino_platform_test/src/features/main_shell/ui/screens/main_shell_screen.dart';
import 'package:casino_platform_test/src/shared/extensions/build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Screen that maps auth states and renders biometric setup view.
class CPBiometricSetupScreen extends StatelessWidget {
  /// Route chunk for biometric setup screen.
  static const String pathChunk = 'biometric-setup';

  /// Route path for biometric setup screen.
  static const CPRoutePath routePath = CPRoutePath(
    CPRoutePaths.authRoot,
    <String>[pathChunk],
  );

  /// Creates [CPBiometricSetupScreen].
  const CPBiometricSetupScreen({super.key});

  Future<void> _onEnableTap(BuildContext context) async {
    await context.read<CPAuthCubit>().enableBiometric();
    if (!context.mounted) {
      return;
    }
    context.goSubRoute(CPMainShellScreen.routePath);
  }

  void _onSkipTap(BuildContext context) {
    context.goSubRoute(CPMainShellScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CPAuthCubit, CPAuthState>(
      listenWhen: (CPAuthState previous, CPAuthState current) =>
          previous.runtimeType != current.runtimeType,
      listener: (BuildContext context, CPAuthState state) {
        if (state is CPUnauthenticatedState) {
          context.goSubRoute(CPLoginScreen.routePath);
        }
      },
      builder: (BuildContext context, CPAuthState state) {
        return switch (state) {
          CPAuthUnknownState() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          CPUnauthenticatedState() => const SizedBox.shrink(),
          CPAuthenticatedState() => CPBiometricSetupView(
              viewModel: CPBiometricSetupViewModel(
                title: context.l10n.enableBiometricTitle,
                description: context.l10n.enableBiometricDescription,
                enableLabel: context.l10n.enableBiometric,
                skipLabel: context.l10n.skipForNow,
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
